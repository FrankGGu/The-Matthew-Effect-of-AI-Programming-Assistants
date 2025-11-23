#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long distinctNames(char ** ideas, int ideasSize) {
    bool groups[26][26];
    memset(groups, false, sizeof(groups));

    for (int i = 0; i < ideasSize; i++) {
        for (int j = i + 1; j < ideasSize; j++) {
            if (ideas[i][0] != ideas[j][0]) {
                char tempI = ideas[i][0];
                ideas[i][0] = ideas[j][0];
                char tempJ = ideas[j][0];
                ideas[j][0] = tempI;

                if (strcmp(ideas[i], ideas[j]) == 0) {
                    groups[tempI - 'a'][tempJ - 'a'] = true;
                    groups[tempJ - 'a'][tempI - 'a'] = true;
                }
                ideas[i][0] = tempJ;
                ideas[j][0] = tempI;
            }
        }
    }

    long long count = 0;
    int groupSizes[26] = {0};
    for (int i = 0; i < ideasSize; i++) {
        groupSizes[ideas[i][0] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        for (int j = i + 1; j < 26; j++) {
            if (groupSizes[i] > 0 && groupSizes[j] > 0) {
                int mutual = 0;
                for (int k = 0; k < ideasSize; k++) {
                    if (ideas[k][0] - 'a' == i) {
                        char originalFirstChar = ideas[k][0];
                        ideas[k][0] = 'a' + j;
                        for (int l = 0; l < ideasSize; l++) {
                            if (ideas[l][0] - 'a' == j && strcmp(ideas[k], ideas[l]) == 0) {
                                mutual++;
                                break;
                            }
                        }
                        ideas[k][0] = originalFirstChar;

                    }
                }

                count += 2LL * (groupSizes[i] - mutual) * (groupSizes[j] - mutual);
            }
        }
    }

    return count;
}
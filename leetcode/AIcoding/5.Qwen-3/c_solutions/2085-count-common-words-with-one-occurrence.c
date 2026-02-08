#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countWords(char **words1, int words1Size, char **words2, int words2Size) {
    int count[26][26][26][26] = {0};
    int i, j, k, l;
    char *word;

    for (i = 0; i < words1Size; i++) {
        word = words1[i];
        for (j = 0; word[j]; j++) {
            if (word[j] >= 'a' && word[j] <= 'z') {
                count[word[j] - 'a'][word[j+1] - 'a'][word[j+2] - 'a'][word[j+3] - 'a']++;
            }
        }
    }

    for (i = 0; i < words2Size; i++) {
        word = words2[i];
        for (j = 0; word[j]; j++) {
            if (word[j] >= 'a' && word[j] <= 'z') {
                count[word[j] - 'a'][word[j+1] - 'a'][word[j+2] - 'a'][word[j+3] - 'a']++;
            }
        }
    }

    int result = 0;
    for (i = 0; i < 26; i++) {
        for (j = 0; j < 26; j++) {
            for (k = 0; k < 26; k++) {
                for (l = 0; l < 26; l++) {
                    if (count[i][j][k][l] == 2) {
                        result++;
                    }
                }
            }
        }
    }

    return result;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int distinctNames(char **ideas, int ideasSize) {
    int count[26][26] = {0};
    int result = 0;

    for (int i = 0; i < ideasSize; i++) {
        int first = ideas[i][0] - 'a';
        for (int j = 1; j < strlen(ideas[i]); j++) {
            count[first][ideas[i][j] - 'a']++;
        }
    }

    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
            if (i != j) {
                result = (result + (count[i][j] * (count[j][i])) % MOD) % MOD;
            }
        }
    }

    return result;
}
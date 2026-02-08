#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimizeConcatenatedLength(char ** words, int wordsSize){
    int dp[wordsSize][26][26];
    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < 26; j++) {
            for (int k = 0; k < 26; k++) {
                dp[i][j][k] = 0;
            }
        }
    }

    int len0 = strlen(words[0]);
    dp[0][words[0][0] - 'a'][words[0][len0 - 1] - 'a'] = len0;

    for (int i = 1; i < wordsSize; i++) {
        int len = strlen(words[i]);
        int first = words[i][0] - 'a';
        int last = words[i][len - 1] - 'a';

        for (int j = 0; j < 26; j++) {
            for (int k = 0; k < 26; k++) {
                if (dp[i - 1][j][k] > 0) {
                    int current = dp[i - 1][j][k];
                    int overlap1 = (k == first) ? 1 : 0;
                    int overlap2 = (last == j) ? 1 : 0;

                    if (dp[i][j][last] == 0 || dp[i][j][last] > current + len - overlap1) {
                        dp[i][j][last] = current + len - overlap1;
                    }

                    if (dp[i][first][k] == 0 || dp[i][first][k] > current + len - overlap2) {
                        dp[i][first][k] = current + len - overlap2;
                    }
                }
            }
        }
    }

    int min_len = -1;
    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
            if (dp[wordsSize - 1][i][j] > 0) {
                if (min_len == -1 || dp[wordsSize - 1][i][j] < min_len) {
                    min_len = dp[wordsSize - 1][i][j];
                }
            }
        }
    }

    return min_len;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestPalindrome(char ** words, int wordsSize) {
    int count[26][26] = {0};
    int maxLen = 0;
    int used[26][26] = {0};

    for (int i = 0; i < wordsSize; i++) {
        char *word = words[i];
        int a = word[0] - 'a';
        int b = word[1] - 'a';
        count[a][b]++;
    }

    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
            if (i == j) {
                if (count[i][j] > 0) {
                    int pairs = count[i][j] / 2;
                    maxLen += pairs * 2;
                    count[i][j] -= pairs * 2;
                }
            } else {
                int pairs = fmin(count[i][j], count[j][i]);
                maxLen += pairs * 2;
                count[i][j] -= pairs;
                count[j][i] -= pairs;
            }
        }
    }

    for (int i = 0; i < 26; i++) {
        if (count[i][i] > 0) {
            maxLen += 2;
            break;
        }
    }

    return maxLen;
}
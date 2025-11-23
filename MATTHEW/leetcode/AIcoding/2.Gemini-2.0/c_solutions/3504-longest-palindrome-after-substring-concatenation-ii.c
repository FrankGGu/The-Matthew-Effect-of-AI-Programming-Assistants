#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestPalindrome(char ** words, int wordsSize) {
    int count[26][26] = {0};
    int ans = 0;
    for (int i = 0; i < wordsSize; i++) {
        int a = words[i][0] - 'a';
        int b = words[i][1] - 'a';
        if (count[b][a] > 0) {
            ans += 4;
            count[b][a]--;
        } else {
            count[a][b]++;
        }
    }
    for (int i = 0; i < 26; i++) {
        if (count[i][i] > 0) {
            ans += 2;
            break;
        }
    }
    return ans;
}
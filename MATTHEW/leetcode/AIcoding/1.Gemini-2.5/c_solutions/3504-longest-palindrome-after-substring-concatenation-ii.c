#include <stdbool.h>

static int min(int a, int b) {
    return a < b ? a : b;
}

int longestPalindrome(char **words, int wordsSize) {
    int freq[26][26] = {0};
    int ans = 0;

    for (int k = 0; k < wordsSize; k++) {
        char *word = words[k];
        int c1 = word[0] - 'a';
        int c2 = word[1] - 'a';
        freq[c1][c2]++;
    }

    bool hasCenter = false;

    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
            if (i == j) {
                ans += (freq[i][i] / 2) * 4;
                if (freq[i][i] % 2 == 1) {
                    hasCenter = true;
                }
            } else if (i < j) {
                int count = min(freq[i][j], freq[j][i]);
                ans += count * 4;
            }
        }
    }

    if (hasCenter) {
        ans += 2;
    }

    return ans;
}
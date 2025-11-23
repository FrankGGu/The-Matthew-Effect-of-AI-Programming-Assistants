#include <string.h>
#include <stdlib.h>

#define MAX_LEN 2000

int manacher(char *s, int *p, int n) {
    int center = 0, right = 0, max_len = 0;
    for (int i = 1; i < n - 1; i++) {
        int mirror = 2 * center - i;
        if (i < right) {
            p[i] = (right - i < p[mirror]) ? right - i : p[mirror];
        } else {
            p[i] = 0;
        }

        while (s[i + p[i] + 1] == s[i - p[i] - 1]) {
            p[i]++;
        }

        if (i + p[i] > right) {
            center = i;
            right = i + p[i];
        }

        if (p[i] > max_len) {
            max_len = p[i];
        }
    }
    return max_len;
}

int longestPalindrome(char* word1, char* word2) {
    int len1 = strlen(word1);
    int len2 = strlen(word2);
    int total_len = len1 + len2;

    char *s = (char*)malloc((2 * total_len + 3) * sizeof(char));
    int *p = (int*)malloc((2 * total_len + 3) * sizeof(int));

    s[0] = '!';
    s[1] = '#';
    int idx = 2;
    for (int i = 0; i < len1; i++) {
        s[idx++] = word1[i];
        s[idx++] = '#';
    }
    for (int i = 0; i < len2; i++) {
        s[idx++] = word2[i];
        s[idx++] = '#';
    }
    s[idx] = '@';
    int n = idx + 1;

    for (int i = 0; i < n; i++) {
        p[i] = 0;
    }

    manacher(s, p, n);

    int res = 0;
    for (int i = 2; i < n - 1; i++) {
        if (p[i] > 0) {
            int left = (i - p[i] - 1) / 2;
            int right = (i + p[i] - 3) / 2;

            if (left < len1 && right >= len1) {
                if (p[i] > res) {
                    res = p[i];
                }
            }
        }
    }

    free(s);
    free(p);
    return res;
}
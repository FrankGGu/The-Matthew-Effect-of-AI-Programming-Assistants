#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestPalindrome(char *s, int start, int end) {
    while (start >= 0 && end < strlen(s) && s[start] == s[end]) {
        start--;
        end++;
    }
    return end - start - 1;
}

int maxProduct(char *s) {
    int n = strlen(s);
    int left[n];
    int right[n];

    for (int i = 0; i < n; i++) {
        left[i] = 0;
        right[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < 2; j++) {
            int l = i;
            int r = i + j;
            int len = longestPalindrome(s, l, r);

            int halfLen = len / 2;
            if(len % 2 == 0) {
                l = i - halfLen + 1;
                r = i + halfLen;
            } else {
                l = i - halfLen;
                r = i + halfLen;
            }

            int currentLen = r - l + 1;

            for (int k = r; k < n; k++) {
                left[k] = (left[k] > currentLen) ? left[k] : currentLen;
            }
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        for (int j = 0; j < 2; j++) {
            int l = i - j;
            int r = i;
            int len = longestPalindrome(s, l, r);

            int halfLen = len / 2;
            if(len % 2 == 0) {
                l = i - halfLen;
                r = i + halfLen - 1;
            } else {
                l = i - halfLen;
                r = i + halfLen;
            }

            int currentLen = r - l + 1;
            for (int k = l; k >= 0; k--) {
                right[k] = (right[k] > currentLen) ? right[k] : currentLen;
            }
        }
    }

    int maxProd = 0;
    for (int i = 0; i < n - 1; i++) {
        int prod = left[i] * right[i + 1];
        maxProd = (maxProd > prod) ? maxProd : prod;
    }

    return maxProd;
}
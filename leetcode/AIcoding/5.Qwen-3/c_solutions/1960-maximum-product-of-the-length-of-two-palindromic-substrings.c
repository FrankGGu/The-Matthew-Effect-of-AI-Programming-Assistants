#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int isPalindrome(char* s, int left, int right) {
    while (left < right) {
        if (s[left] != s[right]) return 0;
        left++;
        right--;
    }
    return 1;
}

int maxProduct(char* s) {
    int n = strlen(s);
    int maxProd = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (isPalindrome(s, i, j)) {
                int len1 = j - i + 1;
                for (int k = 0; k < n; k++) {
                    for (int l = k + 1; l < n; l++) {
                        if (k == i && l == j) continue;
                        if (isPalindrome(s, k, l)) {
                            int len2 = l - k + 1;
                            maxProd = max(maxProd, len1 * len2);
                        }
                    }
                }
            }
        }
    }

    return maxProd;
}
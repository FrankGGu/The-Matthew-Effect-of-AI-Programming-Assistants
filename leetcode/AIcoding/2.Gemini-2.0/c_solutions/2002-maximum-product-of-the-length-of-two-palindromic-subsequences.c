#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxProduct(char * s){
    int n = strlen(s);
    int max_product = 0;

    for (int mask1 = 1; mask1 < (1 << n); mask1++) {
        char sub1[n + 1];
        int len1 = 0;
        for (int i = 0; i < n; i++) {
            if (mask1 & (1 << i)) {
                sub1[len1++] = s[i];
            }
        }
        sub1[len1] = '\0';

        bool is_palindrome1 = true;
        for (int i = 0; i < len1 / 2; i++) {
            if (sub1[i] != sub1[len1 - 1 - i]) {
                is_palindrome1 = false;
                break;
            }
        }

        if (is_palindrome1) {
            for (int mask2 = 1; mask2 < (1 << n); mask2++) {
                bool overlap = false;
                for (int i = 0; i < n; i++) {
                    if ((mask1 & (1 << i)) && (mask2 & (1 << i))) {
                        overlap = true;
                        break;
                    }
                }

                if (!overlap) {
                    char sub2[n + 1];
                    int len2 = 0;
                    for (int i = 0; i < n; i++) {
                        if (mask2 & (1 << i)) {
                            sub2[len2++] = s[i];
                        }
                    }
                    sub2[len2] = '\0';

                    bool is_palindrome2 = true;
                    for (int i = 0; i < len2 / 2; i++) {
                        if (sub2[i] != sub2[len2 - 1 - i]) {
                            is_palindrome2 = false;
                            break;
                        }
                    }

                    if (is_palindrome2) {
                        int product = len1 * len2;
                        if (product > max_product) {
                            max_product = product;
                        }
                    }
                }
            }
        }
    }

    return max_product;
}
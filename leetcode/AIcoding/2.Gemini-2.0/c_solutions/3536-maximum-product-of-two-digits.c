#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxProduct(char * s) {
    int max_product = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            for (int j = i + 1; s[j] != '\0'; j++) {
                if (s[j] >= '0' && s[j] <= '9') {
                    int digit1 = s[i] - '0';
                    int digit2 = s[j] - '0';
                    int product = digit1 * digit2;
                    if (product > max_product) {
                        max_product = product;
                    }
                }
            }
        }
    }
    return max_product;
}
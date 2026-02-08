#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int is_prime(int n) {
    if (n < 2) return 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int sum_of_largest_prime_substrings(char* s) {
    int n = strlen(s);
    int max_sum = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j <= n; j++) {
            char sub[j - i + 1];
            strncpy(sub, s + i, j - i);
            sub[j - i] = '\0';

            int num = atoi(sub);
            if (is_prime(num)) {
                if (num > max_sum) {
                    max_sum = num;
                }
            }
        }
    }

    return max_sum;
}
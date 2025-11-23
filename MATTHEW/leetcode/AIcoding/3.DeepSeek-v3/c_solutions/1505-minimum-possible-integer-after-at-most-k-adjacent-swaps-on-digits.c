#include <stdlib.h>
#include <string.h>

char* minInteger(char* num, int k) {
    int n = strlen(num);
    if (k <= 0) return num;

    for (int i = 0; i < n && k > 0; i++) {
        int min_idx = i;
        for (int j = i + 1; j < n && j <= i + k; j++) {
            if (num[j] < num[min_idx]) {
                min_idx = j;
            }
        }

        if (min_idx != i) {
            char min_digit = num[min_idx];
            for (int j = min_idx; j > i; j--) {
                num[j] = num[j - 1];
            }
            num[i] = min_digit;
            k -= (min_idx - i);
        }
    }

    return num;
}
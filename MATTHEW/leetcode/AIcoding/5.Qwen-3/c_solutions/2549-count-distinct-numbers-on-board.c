#include <stdio.h>
#include <stdlib.h>

int distinctNumbers(int n) {
    int* seen = (int*)calloc(10, sizeof(int));
    int count = 0;
    for (int i = 1; i <= n; i++) {
        int num = i;
        while (num > 0) {
            int digit = num % 10;
            if (!seen[digit]) {
                seen[digit] = 1;
                count++;
            }
            num /= 10;
        }
    }
    free(seen);
    return count;
}
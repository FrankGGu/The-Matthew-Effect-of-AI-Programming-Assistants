#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* divisibilityArray(const char* low, const char* high) {
    int len_low = strlen(low);
    int len_high = strlen(high);
    int* result = (int*)malloc(sizeof(int) * (len_high - len_low + 1));
    int index = 0;

    for (int i = 0; i <= len_high - len_low; i++) {
        long long num = 0;
        for (int j = 0; j < len_low; j++) {
            num = (num * 10 + (low[j] - '0')) % (len_low + 1);
        }
        if (num == 0) {
            result[index++] = i;
        }
    }

    return result;
}
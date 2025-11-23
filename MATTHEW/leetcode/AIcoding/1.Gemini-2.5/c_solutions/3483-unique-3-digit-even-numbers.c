#include <stdlib.h>

int* findEvenNumbers(int* digits, int digitsSize, int* returnSize) {
    int digit_counts[10] = {0};
    for (int i = 0; i < digitsSize; i++) {
        digit_counts[digits[i]]++;
    }

    char can_form[900] = {0};
    int total_found = 0;

    for (int num = 100; num <= 999; num++) {
        if (num % 2 == 0) {
            int c = num % 10;
            int b = (num / 10) % 10;
            int a = num / 100;

            int temp_counts[10];
            for (int i = 0; i < 10; i++) {
                temp_counts[i] = digit_counts[i];
            }

            if (temp_counts[a] > 0) {
                temp_counts[a]--;
                if (temp_counts[b] > 0) {
                    temp_counts[b]--;
                    if (temp_counts[c] > 0) {
                        can_form[num - 100] = 1;
                        total_found++;
                    }
                }
            }
        }
    }

    int* result = (int*)malloc(total_found * sizeof(int));
    if (result == NULL && total_found > 0) {
        *returnSize = 0;
        return NULL;
    }

    int current_index = 0;
    for (int num = 100; num <= 999; num++) {
        if (can_form[num - 100] == 1) {
            result[current_index++] = num;
        }
    }

    *returnSize = total_found;
    return result;
}
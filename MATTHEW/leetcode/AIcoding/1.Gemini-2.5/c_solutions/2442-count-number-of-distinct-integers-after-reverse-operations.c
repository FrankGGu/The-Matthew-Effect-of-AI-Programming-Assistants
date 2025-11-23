#include <stdlib.h> // For malloc, free, qsort

int reverse(int n) {
    int reversed_n = 0;
    while (n > 0) {
        int digit = n % 10;
        reversed_n = reversed_n * 10 + digit;
        n /= 10;
    }
    return reversed_n;
}

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int distinctIntegers(int* nums, int numsSize) {
    int* all_numbers = (int*)malloc(sizeof(int) * numsSize * 2);
    if (all_numbers == NULL) {
        return 0; 
    }

    int current_total_count = 0;

    for (int i = 0; i < numsSize; i++) {
        all_numbers[current_total_count++] = nums[i];
        int rev_num = reverse(nums[i]);
        all_numbers[current_total_count++] = rev_num;
    }

    qsort(all_numbers, current_total_count, sizeof(int), compare);

    if (current_total_count == 0) {
        free(all_numbers);
        return 0;
    }

    int distinct_count = 1;
    for (int i = 1; i < current_total_count; i++) {
        if (all_numbers[i] != all_numbers[i-1]) {
            distinct_count++;
        }
    }

    free(all_numbers);
    return distinct_count;
}
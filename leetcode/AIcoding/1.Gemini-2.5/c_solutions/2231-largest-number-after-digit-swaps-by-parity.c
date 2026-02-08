#include <stdlib.h>

int compare_desc(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int largestNumberAfterDigitSwaps(int num) {
    if (num == 0) {
        return 0;
    }

    int temp_digits[10];
    int count = 0;
    int n = num;
    while (n > 0) {
        temp_digits[count++] = n % 10;
        n /= 10;
    }

    int original_digits[10];
    for (int i = 0; i < count; i++) {
        original_digits[i] = temp_digits[count - 1 - i];
    }

    int even_digits[10];
    int even_count = 0;
    int odd_digits[10];
    int odd_count = 0;

    for (int i = 0; i < count; i++) {
        if (original_digits[i] % 2 == 0) {
            even_digits[even_count++] = original_digits[i];
        } else {
            odd_digits[odd_count++] = original_digits[i];
        }
    }

    qsort(even_digits, even_count, sizeof(int), compare_desc);
    qsort(odd_digits, odd_count, sizeof(int), compare_desc);

    int result = 0;
    int even_idx = 0;
    int odd_idx = 0;

    for (int i = 0; i < count; i++) {
        result *= 10;
        if (original_digits[i] % 2 == 0) {
            result += even_digits[even_idx++];
        } else {
            result += odd_digits[odd_idx++];
        }
    }

    return result;
}
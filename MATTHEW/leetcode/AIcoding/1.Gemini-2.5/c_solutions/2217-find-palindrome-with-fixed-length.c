#include <stdlib.h>

long long power(int base, int exp) {
    long long res = 1;
    for (int i = 0; i < exp; ++i) {
        res *= base;
    }
    return res;
}

long long* kthPalindrome(int* queries, int queriesSize, int intLength, int* returnSize) {
    *returnSize = queriesSize;
    long long* result = (long long*) malloc(sizeof(long long) * queriesSize);

    int len_first_half = (intLength + 1) / 2;
    long long start_num_for_first_half = power(10, len_first_half - 1);
    long long end_num_for_first_half = power(10, len_first_half) - 1;

    for (int i = 0; i < queriesSize; ++i) {
        long long query = queries[i];
        long long first_half_val = start_num_for_first_half + query - 1;

        if (first_half_val > end_num_for_first_half) {
            result[i] = -1;
            continue;
        }

        long long temp_first_half = first_half_val;

        if (intLength % 2 == 1) {
            temp_first_half /= 10;
        }

        long long second_half_val = 0;
        while (temp_first_half > 0) {
            second_half_val = second_half_val * 10 + (temp_first_half % 10);
            temp_first_half /= 10;
        }

        long long multiplier = power(10, intLength / 2);
        long long palindrome = first_half_val * multiplier + second_half_val;

        result[i] = palindrome;
    }

    return result;
}
#include <stdio.h>
#include <stdlib.h>

int maxSum(int* arr, int arrSize, int k) {
    int max_sum = 0;
    int current_sum = 0;
    int freq[10001] = {0};
    int unique_count = 0;

    for (int i = 0; i < arrSize; i++) {
        if (freq[arr[i]] == 0) {
            unique_count++;
        }
        freq[arr[i]]++;
        current_sum += arr[i];

        if (i >= k) {
            freq[arr[i - k]]--;
            if (freq[arr[i - k]] == 0) {
                unique_count--;
            }
            current_sum -= arr[i - k];
        }

        if (i >= k - 1) {
            if (unique_count == k - 1) {
                max_sum = (current_sum > max_sum) ? current_sum : max_sum;
            }
        }
    }

    return max_sum;
}
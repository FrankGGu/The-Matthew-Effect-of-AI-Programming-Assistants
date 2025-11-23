#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long* getDistances(int* arr, int arrSize, int* returnSize){
    long long* result = (long long*)malloc(arrSize * sizeof(long long));
    *returnSize = arrSize;

    int* first_occurrence = (int*)malloc((100001) * sizeof(int));
    int* count = (int*)malloc((100001) * sizeof(int));
    long long* sum = (long long*)malloc((100001) * sizeof(long long));

    for (int i = 0; i <= 100000; i++) {
        first_occurrence[i] = -1;
        count[i] = 0;
        sum[i] = 0;
    }

    for (int i = 0; i < arrSize; i++) {
        if (first_occurrence[arr[i]] == -1) {
            first_occurrence[arr[i]] = i;
        }
        count[arr[i]]++;
        sum[arr[i]] += i;
    }

    for (int i = 0; i < arrSize; i++) {
        long long current_sum = sum[arr[i]];
        int current_count = count[arr[i]];
        int current_index = i;

        result[i] = (long long)current_count * current_index - current_sum;
        result[i] += (current_sum - (long long)current_count * current_index);

        count[arr[i]]--;
        sum[arr[i]] -= current_index;

        if(count[arr[i]] == 0){
            count[arr[i]] = 0;
            sum[arr[i]] = 0;
        }
    }

    free(first_occurrence);
    free(count);
    free(sum);

    return result;
}
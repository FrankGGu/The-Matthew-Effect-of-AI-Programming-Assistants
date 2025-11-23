#include <stdlib.h>
#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maximumSum(int* arr, int arrSize) {
    if (arrSize == 0) {
        return 0;
    }

    int prev_no_del = arr[0];
    int prev_one_del = INT_MIN / 2; 

    int max_overall = arr[0];

    for (int i = 1; i < arrSize; i++) {
        int current_no_del = max(arr[i], arr[i] + prev_no_del);
        int current_one_del = max(prev_no_del, arr[i] + prev_one_del);

        max_overall = max(max_overall, current_no_del);
        max_overall = max(max_overall, current_one_del);

        prev_no_del = current_no_del;
        prev_one_del = current_one_del;
    }

    return max_overall;
}
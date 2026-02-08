#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maximumSum(int* arr, int arrSize) {
    if (arrSize == 0) {
        return 0;
    }

    int dp0_curr = arr[0];
    int dp1_curr = 0;

    int max_overall = arr[0];
    max_overall = max(max_overall, dp1_curr); 

    for (int i = 1; i < arrSize; ++i) {
        int new_dp1_curr = max(dp0_curr, dp1_curr + arr[i]);
        int new_dp0_curr = max(arr[i], dp0_curr + arr[i]);

        max_overall = max(max_overall, new_dp0_curr);
        max_overall = max(max_overall, new_dp1_curr);

        dp0_curr = new_dp0_curr;
        dp1_curr = new_dp1_curr;
    }

    return max_overall;
}
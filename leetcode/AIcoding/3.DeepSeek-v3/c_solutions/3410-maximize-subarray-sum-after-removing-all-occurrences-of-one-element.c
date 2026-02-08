int maximumSum(int* arr, int arrSize) {
    if (arrSize == 1) return arr[0];

    int dp0 = arr[0];
    int dp1 = 0;
    int res = arr[0];

    for (int i = 1; i < arrSize; i++) {
        dp1 = (dp0 > dp1 + arr[i]) ? dp0 : dp1 + arr[i];
        dp0 = (dp0 > 0) ? dp0 + arr[i] : arr[i];
        if (dp0 > res) res = dp0;
        if (dp1 > res) res = dp1;
    }

    return res;
}
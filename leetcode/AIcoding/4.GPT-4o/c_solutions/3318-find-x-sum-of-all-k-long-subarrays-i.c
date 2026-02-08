int xSum(int* arr, int arrSize, int k) {
    if (arrSize < k) return 0;
    int sum = 0;
    for (int i = 0; i < k; i++) {
        sum += arr[i];
    }
    int ans = sum;
    for (int i = k; i < arrSize; i++) {
        sum += arr[i] - arr[i - k];
        ans += sum;
    }
    return ans;
}
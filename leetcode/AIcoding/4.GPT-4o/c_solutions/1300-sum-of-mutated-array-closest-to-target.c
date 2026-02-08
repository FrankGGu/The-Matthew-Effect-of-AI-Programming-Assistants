int findBestValue(int* arr, int arrSize, int target) {
    int left = 0, right = 100000;
    while (left < right) {
        int mid = (left + right) / 2, sum = 0;
        for (int i = 0; i < arrSize; i++) {
            sum += arr[i] < mid ? arr[i] : mid;
        }
        if (sum < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    int sum1 = 0, sum2 = 0;
    for (int i = 0; i < arrSize; i++) {
        sum1 += arr[i] < left ? arr[i] : left;
        sum2 += arr[i] < left - 1 ? arr[i] : left - 1;
    }
    return (abs(sum1 - target) < abs(sum2 - target)) ? left : left - 1;
}
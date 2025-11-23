int maxSum(int* arr, int arrSize, int k) {
    int max_sum = 0, current_sum = 0;

    for (int i = 0; i < k; i++) {
        current_sum += arr[i];
    }

    max_sum = current_sum;

    for (int i = k; i < arrSize; i++) {
        current_sum += arr[i] - arr[i - k];
        if (current_sum > max_sum) {
            max_sum = current_sum;
        }
    }

    return max_sum;
}
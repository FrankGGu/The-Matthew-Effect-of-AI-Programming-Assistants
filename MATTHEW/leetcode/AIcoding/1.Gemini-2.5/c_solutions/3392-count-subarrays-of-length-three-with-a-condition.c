int numOfSubarrays(int* arr, int arrSize, int k, int threshold) {
    if (arrSize < k) {
        return 0;
    }

    int count = 0;
    long long current_sum = 0;
    int target_sum = k * threshold;

    for (int i = 0; i < k; i++) {
        current_sum += arr[i];
    }

    if (current_sum >= target_sum) {
        count++;
    }

    for (int i = k; i < arrSize; i++) {
        current_sum = current_sum - arr[i - k] + arr[i];
        if (current_sum >= target_sum) {
            count++;
        }
    }

    return count;
}
int numOfSubarrays(int* arr, int arrSize, int k, int threshold) {
    if (arrSize < k) {
        return 0;
    }

    int count = 0;
    long long current_sum = 0;
    long long target_sum = (long long)threshold * k;

    // Calculate sum for the first window
    for (int i = 0; i < k; i++) {
        current_sum += arr[i];
    }

    // Check the first window
    if (current_sum >= target_sum) {
        count++;
    }

    // Slide the window
    for (int i = k; i < arrSize; i++) {
        current_sum += arr[i] - arr[i - k];
        if (current_sum >= target_sum) {
            count++;
        }
    }

    return count;
}
int numOfSubarrays(int* arr, int arrSize, int k, int threshold) {
    int count = 0, sum = 0, target = k * threshold;

    for (int i = 0; i < k; i++) {
        sum += arr[i];
    }

    if (sum >= target) {
        count++;
    }

    for (int i = k; i < arrSize; i++) {
        sum += arr[i] - arr[i - k];
        if (sum >= target) {
            count++;
        }
    }

    return count;
}
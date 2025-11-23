int maximumSum(int* arr, int arrSize) {
    int max_sum = 0, current_sum = 0, freq[100001] = {0};
    int left = 0;

    for (int right = 0; right < arrSize; right++) {
        current_sum += arr[right];
        freq[arr[right] + 50000]++;

        while (freq[arr[right] + 50000] > 1) {
            freq[arr[left] + 50000]--;
            current_sum -= arr[left];
            left++;
        }

        if (current_sum > max_sum) {
            max_sum = current_sum;
        }
    }

    return max_sum;
}
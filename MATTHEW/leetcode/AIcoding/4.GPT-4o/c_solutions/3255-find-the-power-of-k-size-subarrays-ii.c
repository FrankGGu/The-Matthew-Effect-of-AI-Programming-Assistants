int countKSubarrays(int* arr, int arrSize, int k) {
    int count = 0;
    for (int i = 0; i <= arrSize - k; i++) {
        int sum = 0;
        for (int j = 0; j < k; j++) {
            sum += arr[i + j];
        }
        count += (sum % k == 0);
    }
    return count;
}
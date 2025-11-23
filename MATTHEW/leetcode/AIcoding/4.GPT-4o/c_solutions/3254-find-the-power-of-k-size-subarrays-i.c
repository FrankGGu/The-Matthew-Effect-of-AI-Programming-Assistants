int countKSubarrays(int* arr, int arrSize, int k) {
    int count = 0;
    for (int i = 0; i <= arrSize - k; i++) {
        int sum = 0;
        for (int j = i; j < i + k; j++) {
            sum += arr[j];
        }
        if (sum % k == 0) {
            count++;
        }
    }
    return count;
}
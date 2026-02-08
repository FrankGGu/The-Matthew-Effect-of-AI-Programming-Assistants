int numOfSubarrays(int* arr, int arrSize) {
    long long odd_count = 0;
    long long even_count = 1; // Represents an empty prefix sum of 0, which is even
    long long current_sum = 0;
    long long total_subarrays = 0;
    long long MOD = 1000000007;

    for (int i = 0; i < arrSize; i++) {
        current_sum += arr[i];
        if (current_sum % 2 == 0) {
            total_subarrays = (total_subarrays + odd_count) % MOD;
            even_count++;
        } else {
            total_subarrays = (total_subarrays + even_count) % MOD;
            odd_count++;
        }
    }

    return (int)total_subarrays;
}
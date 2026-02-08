int numOfSubarrays(int* arr, int arrSize) {
    int mod = 1000000007;
    int odd = 0, even = 1;
    int sum = 0, result = 0;

    for (int i = 0; i < arrSize; i++) {
        sum += arr[i];
        if (sum % 2 == 0) {
            result = (result + odd) % mod;
            even++;
        } else {
            result = (result + even) % mod;
            odd++;
        }
    }

    return result;
}
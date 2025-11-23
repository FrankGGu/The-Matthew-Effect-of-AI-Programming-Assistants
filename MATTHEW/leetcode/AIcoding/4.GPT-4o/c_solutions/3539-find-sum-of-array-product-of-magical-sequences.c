#define MOD 1000000007

int findSum(int* arr, int arrSize) {
    long long totalSum = 0;
    long long prefixSum = 0;
    for (int i = 0; i < arrSize; i++) {
        prefixSum = (prefixSum + arr[i]) % MOD;
        totalSum = (totalSum + prefixSum) % MOD;
    }
    return (int)totalSum;
}
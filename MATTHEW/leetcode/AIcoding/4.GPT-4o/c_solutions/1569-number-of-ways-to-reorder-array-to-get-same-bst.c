#define MOD 1000000007

long long comb(int n, int k) {
    long long res = 1;
    for (int i = 0; i < k; i++) {
        res = res * (n - i) % MOD;
        res = res * modInverse(i + 1) % MOD;
    }
    return res;
}

long long modInverse(int a) {
    long long res = 1, mod = MOD - 2;
    while (mod) {
        if (mod & 1) res = res * a % MOD;
        a = a * a % MOD;
        mod >>= 1;
    }
    return res;
}

int numOfWays(int* nums, int numsSize) {
    if (numsSize <= 2) return 1;
    int leftCount = 0, rightCount = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < nums[0]) leftCount++;
        else rightCount++;
    }
    long long ways = comb(leftCount + rightCount, leftCount);
    return ways * numOfWays(nums + 1, leftCount) % MOD * numOfWays(nums + leftCount + 1, rightCount) % MOD;
}
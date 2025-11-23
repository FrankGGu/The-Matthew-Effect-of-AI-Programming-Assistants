typedef long long ll;

ll sumOfPower(int* nums, int numsSize) {
    ll mod = 1e9 + 7;
    ll total = 0;
    ll prefixSum = 0;

    qsort(nums, numsSize, sizeof(int), cmp);

    for (int i = 0; i < numsSize; i++) {
        prefixSum = (prefixSum * 2 + nums[i]) % mod;
        total = (total + prefixSum * nums[i]) % mod;
    }

    return total;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}
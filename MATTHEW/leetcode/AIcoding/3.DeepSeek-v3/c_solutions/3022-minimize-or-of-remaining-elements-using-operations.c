int minOrAfterOperations(int* nums, int numsSize, int k) {
    int res = 0;
    for (int bit = 29; bit >= 0; bit--) {
        int target = res | ((1 << bit) - 1);
        int cnt = 0;
        int cur = (1 << 30) - 1;
        for (int i = 0; i < numsSize; i++) {
            cur &= nums[i];
            if ((cur | target) == target) {
                cnt++;
                cur = (1 << 30) - 1;
            }
        }
        if (numsSize - cnt > k) {
            res |= (1 << bit);
        }
    }
    return res;
}
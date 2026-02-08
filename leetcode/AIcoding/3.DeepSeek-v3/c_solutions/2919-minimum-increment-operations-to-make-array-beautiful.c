int minIncrementOperations(int* nums, int numsSize, int k) {
    long long dp0 = 0, dp1 = 0, dp2 = 0;

    for (int i = 0; i < numsSize; i++) {
        long long need = (k > nums[i]) ? (k - nums[i]) : 0;
        long long new_dp0 = dp1;
        long long new_dp1 = dp2;
        long long new_dp2 = need + fminl(fminl(dp0, dp1), dp2);

        dp0 = new_dp0;
        dp1 = new_dp1;
        dp2 = new_dp2;
    }

    return (int)fminl(fminl(dp0, dp1), dp2);
}
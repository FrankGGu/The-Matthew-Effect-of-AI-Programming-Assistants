function numSubseqsToSumWithLimit(nums, target) {
    nums.sort((a, b) => a - b);
    const MOD = 10 ** 9 + 7;
    let count = 0;
    let left = 0;
    let right = nums.length - 1;

    while (left <= right) {
        if (nums[left] + nums[right] > target) {
            right--;
        } else {
            count = (count + Math.pow(2, right - left)) % MOD;
            left++;
        }
    }

    return count;
}
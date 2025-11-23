function canMakeZero(nums, k) {
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
        if (sum % k === 0) {
            return true;
        }
    }
    return false;
}
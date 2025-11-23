function numSubarraysWithSum(nums, goal) {
    const count = (target) => {
        let sum = 0, left = 0, result = 0;
        for (let right = 0; right < nums.length; right++) {
            sum += nums[right];
            while (sum > target) {
                sum -= nums[left++];
            }
            result += right - left + 1;
        }
        return result;
    };
    return count(goal) - count(goal - 1);
}
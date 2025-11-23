var minSubarray = function(nums) {
    let n = nums.length;
    let sum = 0;
    for (let num of nums) {
        sum += num;
    }
    let ans = sum;
    let currSum = 0;
    for (let i = 0; i < n; i++) {
        currSum += nums[i];
        ans = Math.min(ans, sum - currSum);
        if (currSum > 0) {
            currSum = 0;
        }
    }
    return ans;
};
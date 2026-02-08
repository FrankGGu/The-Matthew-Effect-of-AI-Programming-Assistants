var minSizeSubarray = function(nums, target) {
    const n = nums.length;
    let sum = nums.reduce((acc, num) => acc + num, 0);
    let k = Math.floor(target / sum);
    target %= sum;
    let ans = Infinity;
    let left = 0, currSum = 0;
    for (let right = 0; right < 2 * n; right++) {
        currSum += nums[right % n];
        while (currSum > target) {
            currSum -= nums[left % n];
            left++;
        }
        if (currSum === target) {
            ans = Math.min(ans, right - left + 1);
        }
    }
    return ans === Infinity ? -1 : ans + k * n;
};
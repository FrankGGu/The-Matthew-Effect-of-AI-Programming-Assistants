var sumOfSubarrays = function(nums, k) {
    let sum = 0;
    for (let i = 0; i <= nums.length - k; i++) {
        let currentSum = 0;
        for (let j = i; j < i + k; j++) {
            currentSum += nums[j];
        }
        sum += currentSum;
    }
    return sum;
};
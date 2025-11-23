var numOfSubarrays = function(nums, k, threshold) {
    let count = 0;
    for (let i = 0; i <= nums.length - k; i++) {
        let sum = 0;
        for (let j = i; j < i + k; j++) {
            sum += nums[j];
        }
        if (sum / k > threshold) {
            count++;
        }
    }
    return count;
};
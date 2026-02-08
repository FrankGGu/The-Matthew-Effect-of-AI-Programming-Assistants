var smallerNumbersThanCurrent = function(nums) {
    const n = nums.length;
    const result = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i !== j && nums[j] < nums[i]) {
                result[i]++;
            }
        }
    }
    return result;
};
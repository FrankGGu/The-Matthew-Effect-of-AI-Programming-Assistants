var countQuadruplets = function(nums) {
    let n = nums.length;
    let count = 0;
    for (let i = 0; i < n - 3; i++) {
        for (let j = i + 1; j < n - 2; j++) {
            for (let k = j + 1; k < n - 1; k++) {
                for (let l = k + 1; l < n; l++) {
                    if (nums[i] < nums[k] && nums[k] < nums[l] && nums[j] > nums[l]) {
                        count++;
                    }
                }
            }
        }
    }
    return count;
};
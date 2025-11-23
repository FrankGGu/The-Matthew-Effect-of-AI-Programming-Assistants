var countQuadruplets = function(nums) {
    const n = nums.length;
    let count = 0;

    for (let j = 0; j < n; j++) {
        for (let k = j + 1; k < n; k++) {
            if (nums[j] > nums[k]) {
                let left = 0;
                let right = 0;

                for (let i = 0; i < j; i++) {
                    if (nums[i] < nums[k]) {
                        left++;
                    }
                }

                for (let l = k + 1; l < n; l++) {
                    if (nums[j] < nums[l]) {
                        right++;
                    }
                }

                count += left * right;
            }
        }
    }

    return count;
};
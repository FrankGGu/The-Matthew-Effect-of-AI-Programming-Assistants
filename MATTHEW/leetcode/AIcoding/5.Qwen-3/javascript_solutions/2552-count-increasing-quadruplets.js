function countIncreasingQuadruplets(nums) {
    const n = nums.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (nums[j] > nums[i]) {
                for (let k = j + 1; k < n; k++) {
                    if (nums[k] > nums[j]) {
                        for (let l = k + 1; l < n; l++) {
                            if (nums[l] > nums[k]) {
                                count++;
                            }
                        }
                    }
                }
            }
        }
    }
    return count;
}
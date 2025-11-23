function countSpecialQuadruplets(nums) {
    let count = 0;
    const n = nums.length;
    for (let a = 0; a < n; a++) {
        for (let b = a + 1; b < n; b++) {
            for (let c = b + 1; c < n; c++) {
                for (let d = c + 1; d < n; d++) {
                    if (nums[a] + nums[b] + nums[c] === nums[d]) {
                        count++;
                    }
                }
            }
        }
    }
    return count;
}
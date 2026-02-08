var countMaxOrSubsets = function(nums) {
    let maxOR = 0;
    for (let i = 0; i < nums.length; i++) {
        maxOR |= nums[i];
    }

    let count = 0;
    const n = nums.length;

    for (let i = 0; i < (1 << n); i++) {
        let currentOR = 0;
        for (let j = 0; j < n; j++) {
            if ((i >> j) & 1) {
                currentOR |= nums[j];
            }
        }
        if (currentOR === maxOR) {
            count++;
        }
    }

    return count;
};
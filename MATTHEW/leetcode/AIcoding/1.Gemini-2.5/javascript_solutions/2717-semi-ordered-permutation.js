var semiOrderedPermutation = function(nums) {
    const n = nums.length;
    let idx1 = -1;
    let idxn = -1;

    for (let i = 0; i < n; i++) {
        if (nums[i] === 1) {
            idx1 = i;
        }
        if (nums[i] === n) {
            idxn = i;
        }
    }

    let swaps = 0;

    swaps += idx1;

    let idxn_after_1_moves;
    if (idxn < idx1) {
        idxn_after_1_moves = idxn + 1;
    } else {
        idxn_after_1_moves = idxn;
    }

    swaps += (n - 1) - idxn_after_1_moves;

    return swaps;
};
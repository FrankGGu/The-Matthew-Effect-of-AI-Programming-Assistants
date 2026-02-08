var semiOrderedPermutation = function(nums) {
    const n = nums.length;
    let pos1 = nums.indexOf(1);
    let posN = nums.indexOf(n);
    let swaps = pos1 + (n - 1 - posN);
    if (pos1 > posN) {
        swaps--;
    }
    return swaps;
};
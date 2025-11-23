function semiOrderedPermutation(nums) {
    let n = nums.length;
    let pos1 = nums.indexOf(1);
    let posn = nums.indexOf(n);

    if (pos1 < posn) {
        return pos1 + (n - 1 - posn);
    } else {
        return pos1 + (n - 1 - posn) - 1;
    }
}
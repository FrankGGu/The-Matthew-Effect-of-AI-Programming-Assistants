var semiOrderedPermutation = function(nums) {
    let n = nums.length;
    let first = nums.indexOf(1);
    let last = nums.indexOf(n);

    let result = 0;
    if (first < last) {
        result = first + (n - 1 - last);
    } else {
        result = first + (n - 1 - last) - 1;
    }

    return result;
};
var minImpossibleOR = function(nums) {
    let res = 1;
    const set = new Set(nums);
    while (set.has(res)) {
        res <<= 1;
    }
    return res;
};
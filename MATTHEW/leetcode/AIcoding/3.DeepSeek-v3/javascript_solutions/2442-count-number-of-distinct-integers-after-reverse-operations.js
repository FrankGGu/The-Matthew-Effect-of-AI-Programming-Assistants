var countDistinctIntegers = function(nums) {
    const set = new Set(nums);
    for (const num of nums) {
        const reversed = parseInt(num.toString().split('').reverse().join(''), 10);
        set.add(reversed);
    }
    return set.size;
};
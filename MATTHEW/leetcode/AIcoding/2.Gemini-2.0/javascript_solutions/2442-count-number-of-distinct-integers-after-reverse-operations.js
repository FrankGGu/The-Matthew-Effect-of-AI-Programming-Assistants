var countDistinctIntegers = function(nums) {
    let set = new Set(nums);
    for (let num of nums) {
        let reversed = parseInt(num.toString().split('').reverse().join(''));
        set.add(reversed);
    }
    return set.size;
};
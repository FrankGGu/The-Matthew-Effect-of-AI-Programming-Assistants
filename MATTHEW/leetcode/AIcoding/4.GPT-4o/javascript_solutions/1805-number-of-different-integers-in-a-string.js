var numDifferentIntegers = function(word) {
    const set = new Set();
    const nums = word.match(/\d+/g);
    if (nums) {
        nums.forEach(num => set.add(BigInt(num).toString()));
    }
    return set.size;
};
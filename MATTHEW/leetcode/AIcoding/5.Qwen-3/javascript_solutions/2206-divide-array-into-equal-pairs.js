var divideArray = function(nums) {
    if (nums.length % 2 !== 0) return false;
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }
    for (const key in count) {
        if (count[key] % 2 !== 0) return false;
    }
    return true;
};
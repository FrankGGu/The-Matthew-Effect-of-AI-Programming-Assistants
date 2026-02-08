var divideArray = function(nums) {
    const frequency = {};
    for (const num of nums) {
        frequency[num] = (frequency[num] || 0) + 1;
    }
    for (const key in frequency) {
        if (frequency[key] % 2 !== 0) {
            return false;
        }
    }
    return true;
};
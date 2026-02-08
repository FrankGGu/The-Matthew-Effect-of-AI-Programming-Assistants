var divideArray = function(nums) {
    const counts = {};
    for (const num of nums) {
        counts[num] = (counts[num] || 0) + 1;
    }

    for (const num in counts) {
        if (counts[num] % 2 !== 0) {
            return false;
        }
    }

    return true;
};
var minimumOperations = function(nums) {
    const count = {};
    for (const num of nums) {
        if (num !== 0) {
            count[num] = (count[num] || 0) + 1;
        }
    }
    return Object.keys(count).length;
};
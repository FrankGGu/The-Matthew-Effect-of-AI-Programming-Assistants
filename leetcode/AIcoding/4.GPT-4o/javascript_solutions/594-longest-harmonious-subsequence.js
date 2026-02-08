var findLHS = function(nums) {
    const count = {};
    let maxLength = 0;

    for (let num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    for (let key in count) {
        if (count[key + 1]) {
            maxLength = Math.max(maxLength, count[key] + count[key + 1]);
        }
    }

    return maxLength;
};
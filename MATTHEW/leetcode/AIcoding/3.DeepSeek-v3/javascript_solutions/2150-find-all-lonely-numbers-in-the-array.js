var findLonely = function(nums) {
    const frequency = {};
    const result = [];

    for (const num of nums) {
        frequency[num] = (frequency[num] || 0) + 1;
    }

    for (const num of nums) {
        if (frequency[num] === 1 && !frequency[num - 1] && !frequency[num + 1]) {
            result.push(num);
        }
    }

    return result;
};
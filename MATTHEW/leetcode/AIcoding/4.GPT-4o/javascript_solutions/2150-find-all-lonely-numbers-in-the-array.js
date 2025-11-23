var findLonely = function(nums) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }
    const result = [];
    for (const num of nums) {
        if (count[num] === 1 && !count[num - 1] && !count[num + 1]) {
            result.push(num);
        }
    }
    return result;
};
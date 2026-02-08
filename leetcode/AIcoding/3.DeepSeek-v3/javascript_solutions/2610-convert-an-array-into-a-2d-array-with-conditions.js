var findMatrix = function(nums) {
    const freq = {};
    const result = [];

    for (const num of nums) {
        if (freq[num] === undefined) {
            freq[num] = 0;
        }
        if (freq[num] >= result.length) {
            result.push([]);
        }
        result[freq[num]].push(num);
        freq[num]++;
    }

    return result;
};
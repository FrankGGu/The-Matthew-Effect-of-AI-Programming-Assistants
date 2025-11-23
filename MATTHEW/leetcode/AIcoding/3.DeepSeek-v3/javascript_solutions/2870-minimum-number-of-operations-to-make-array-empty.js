var minOperations = function(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }

    let operations = 0;
    for (const count of Object.values(freq)) {
        if (count === 1) {
            return -1;
        }
        operations += Math.floor(count / 3);
        if (count % 3 !== 0) {
            operations += 1;
        }
    }
    return operations;
};
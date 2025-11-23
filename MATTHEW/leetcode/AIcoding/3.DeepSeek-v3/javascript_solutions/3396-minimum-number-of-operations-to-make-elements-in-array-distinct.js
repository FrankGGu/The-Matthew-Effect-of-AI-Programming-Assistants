var minOperations = function(nums) {
    let freq = {};
    let operations = 0;

    for (let num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }

    for (let key in freq) {
        let count = freq[key];
        if (count > 1) {
            operations += Math.floor(count / 2);
        }
    }

    return operations;
};
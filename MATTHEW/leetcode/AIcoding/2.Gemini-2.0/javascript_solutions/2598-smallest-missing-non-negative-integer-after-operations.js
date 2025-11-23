var findSmallestMissing = function(nums, value) {
    const freq = new Array(value).fill(0);
    for (const num of nums) {
        freq[((num % value) + value) % value]++;
    }

    let missing = 0;
    while (true) {
        const index = missing % value;
        if (freq[index] === 0) {
            return missing;
        }
        freq[index]--;
        missing++;
    }
};
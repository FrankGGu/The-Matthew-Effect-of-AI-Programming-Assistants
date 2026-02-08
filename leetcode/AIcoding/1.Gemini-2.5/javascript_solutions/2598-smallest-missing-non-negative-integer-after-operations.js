var smallestMissingValueAfterOperations = function(nums, value) {
    const counts = new Array(value).fill(0);

    for (let i = 0; i < nums.length; i++) {
        counts[nums[i] % value]++;
    }

    for (let k = 0; ; k++) {
        const remainder = k % value;
        if (counts[remainder] === 0) {
            return k;
        }
        counts[remainder]--;
    }
};
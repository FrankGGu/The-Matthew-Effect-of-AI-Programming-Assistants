function findXValue(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }
    for (let x = 0; x <= nums.length; x++) {
        let count = 0;
        for (const key in freq) {
            if (freq[key] === x) {
                count++;
            }
        }
        if (count === x) {
            return x;
        }
    }
    return -1;
}
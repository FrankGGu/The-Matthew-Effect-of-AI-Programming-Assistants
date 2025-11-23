var maximumSize = function(nums) {
    const freq = new Map();
    let maxSetSize = 0;

    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    for (const [key, value] of freq) {
        if (value > 1) {
            maxSetSize += 1;
        } else {
            maxSetSize += 1;
        }
    }

    return maxSetSize;
};
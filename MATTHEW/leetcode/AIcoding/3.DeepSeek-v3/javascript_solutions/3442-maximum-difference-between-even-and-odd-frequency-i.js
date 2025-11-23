var maxFrequencyDifference = function(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }

    let maxEven = -Infinity;
    let minOdd = Infinity;

    for (const key in freq) {
        const count = freq[key];
        if (count % 2 === 0) {
            if (count > maxEven) {
                maxEven = count;
            }
        } else {
            if (count < minOdd) {
                minOdd = count;
            }
        }
    }

    if (maxEven === -Infinity || minOdd === Infinity) {
        return 0;
    }

    return maxEven - minOdd;
};
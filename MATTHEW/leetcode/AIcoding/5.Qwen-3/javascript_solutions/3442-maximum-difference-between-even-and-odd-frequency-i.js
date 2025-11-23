function maximumDifference(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }

    let maxEven = -1;
    let maxOdd = -1;

    for (const num in freq) {
        const count = freq[num];
        if (count % 2 === 0) {
            if (num > maxEven) {
                maxEven = num;
            }
        } else {
            if (num > maxOdd) {
                maxOdd = num;
            }
        }
    }

    if (maxEven === -1 || maxOdd === -1) {
        return -1;
    }

    return maxEven - maxOdd;
}
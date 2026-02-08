var numberOfPairs = function(nums) {
    const counts = {};
    for (const num of nums) {
        counts[num] = (counts[num] || 0) + 1;
    }

    let pairs = 0;
    let remainders = 0;

    for (const num in counts) {
        pairs += Math.floor(counts[num] / 2);
        remainders += counts[num] % 2;
    }

    return [pairs, remainders];
};
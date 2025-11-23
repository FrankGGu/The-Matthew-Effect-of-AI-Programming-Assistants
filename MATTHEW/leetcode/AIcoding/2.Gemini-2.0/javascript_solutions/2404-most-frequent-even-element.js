var mostFrequentEven = function(nums) {
    const evenCounts = {};
    for (const num of nums) {
        if (num % 2 === 0) {
            evenCounts[num] = (evenCounts[num] || 0) + 1;
        }
    }

    let mostFrequent = -1;
    let maxCount = 0;

    for (const num in evenCounts) {
        const count = evenCounts[num];
        if (count > maxCount) {
            maxCount = count;
            mostFrequent = parseInt(num);
        } else if (count === maxCount) {
            mostFrequent = Math.min(mostFrequent, parseInt(num));
        }
    }

    return mostFrequent;
};
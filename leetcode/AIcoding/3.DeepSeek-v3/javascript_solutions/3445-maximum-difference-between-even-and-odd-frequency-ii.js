var maxDiffBetweenFrequencies = function(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }

    const evenFreq = [];
    const oddFreq = [];

    for (const key in freq) {
        const count = freq[key];
        if (count % 2 === 0) {
            evenFreq.push(count);
        } else {
            oddFreq.push(count);
        }
    }

    if (evenFreq.length === 0 || oddFreq.length === 0) {
        return 0;
    }

    evenFreq.sort((a, b) => a - b);
    oddFreq.sort((a, b) => a - b);

    const diff1 = Math.abs(evenFreq[evenFreq.length - 1] - oddFreq[0]);
    const diff2 = Math.abs(oddFreq[oddFreq.length - 1] - evenFreq[0]);

    return Math.max(diff1, diff2);
};
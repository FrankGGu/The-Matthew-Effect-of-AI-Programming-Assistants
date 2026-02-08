var maxFrequencyScore = function(nums) {
    let freqMap = new Map();
    for (let num of nums) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    let evenFreq = [];
    let oddFreq = [];
    for (let freq of freqMap.values()) {
        if (freq % 2 === 0) {
            evenFreq.push(freq);
        } else {
            oddFreq.push(freq);
        }
    }

    evenFreq.sort((a, b) => a - b);
    oddFreq.sort((a, b) => a - b);

    let sumEven = 0;
    for (let freq of evenFreq) {
        sumEven += freq;
    }

    let sumOdd = 0;
    for (let freq of oddFreq) {
        sumOdd += freq;
    }

    if (oddFreq.length === 0) {
        return -1;
    }

    let maxDiff = sumEven - (sumOdd - oddFreq[0]);
    if (evenFreq.length > 0) {
        maxDiff = Math.max(maxDiff, (sumEven - evenFreq[evenFreq.length - 1]) - sumOdd + oddFreq[0]);
    }

    return maxDiff;
};
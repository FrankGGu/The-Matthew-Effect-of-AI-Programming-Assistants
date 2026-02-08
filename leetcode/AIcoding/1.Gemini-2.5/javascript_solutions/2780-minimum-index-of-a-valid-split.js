function minimumIndex(nums) {
    const n = nums.length;
    const counts = new Map();

    for (const num of nums) {
        counts.set(num, (counts.get(num) || 0) + 1);
    }

    let dominantVal = -1;
    let dominantFreqTotal = 0;

    for (const [val, freq] of counts.entries()) {
        if (freq * 2 > n) {
            dominantVal = val;
            dominantFreqTotal = freq;
            break;
        }
    }

    if (dominantVal === -1) {
        return -1;
    }

    let leftFreq = 0; // Frequency of dominantVal in nums[0...i]
    let rightFreq = dominantFreqTotal; // Frequency of dominantVal in nums[i+1...n-1]

    for (let i = 0; i < n - 1; i++) {
        if (nums[i] === dominantVal) {
            leftFreq++;
            rightFreq--;
        }

        const leftLen = i + 1;
        const rightLen = n - (i + 1);

        if (leftFreq * 2 > leftLen && rightFreq * 2 > rightLen) {
            return i;
        }
    }

    return -1;
}
function distinctDifferenceArray(nums) {
    const n = nums.length;
    const result = new Array(n);
    const freq = new Map();

    for (let i = 0; i < n; i++) {
        freq.set(nums[i], (freq.get(nums[i]) || 0) + 1);
    }

    const leftFreq = new Map();
    let uniqueCount = 0;

    for (let i = 0; i < n; i++) {
        const num = nums[i];

        if (!leftFreq.has(num)) {
            uniqueCount++;
            leftFreq.set(num, 1);
        } else {
            leftFreq.set(num, leftFreq.get(num) + 1);
        }

        freq.set(num, freq.get(num) - 1);

        if (freq.get(num) === 0) {
            freq.delete(num);
        }

        const rightUnique = freq.size;
        result[i] = uniqueCount - rightUnique;
    }

    return result;
}
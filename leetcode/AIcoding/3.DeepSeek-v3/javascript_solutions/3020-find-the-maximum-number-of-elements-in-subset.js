var maximumLength = function(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }

    let maxLen = 1;
    const processed = new Set();

    for (const num of nums) {
        if (processed.has(num)) continue;
        processed.add(num);

        let current = num;
        let currentLen = 0;

        while (freq[current] >= 1) {
            if (current !== 1 && freq[current] < 2) {
                currentLen += 1;
                break;
            }
            currentLen += freq[current] >= 2 ? 2 : 1;
            if (current === 1) break;
            current = current * current;
        }

        maxLen = Math.max(maxLen, currentLen);
    }

    return maxLen;
};
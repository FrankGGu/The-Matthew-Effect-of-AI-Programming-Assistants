var shortestSeq = function(big, small) {
    const smallSet = new Set(small);
    const freq = {};
    let required = smallSet.size;
    let formed = 0;
    let left = 0;
    let result = [];
    let minLen = Infinity;

    for (let right = 0; right < big.length; right++) {
        const char = big[right];
        if (!smallSet.has(char)) continue;

        freq[char] = (freq[char] || 0) + 1;
        if (freq[char] === 1) formed++;

        while (formed === required) {
            const currentLen = right - left + 1;
            if (currentLen < minLen) {
                minLen = currentLen;
                result = [[left, right]];
            } else if (currentLen === minLen) {
                result.push([left, right]);
            }

            const leftChar = big[left];
            if (smallSet.has(leftChar)) {
                freq[leftChar]--;
                if (freq[leftChar] === 0) formed--;
            }
            left++;
        }
    }

    const freqMap = {};
    for (const [start, end] of result) {
        const len = end - start + 1;
        freqMap[len] = (freqMap[len] || 0) + 1;
    }

    const output = [];
    for (const len in freqMap) {
        output.push([parseInt(len), freqMap[len]]);
    }
    output.sort((a, b) => a[0] - b[0]);

    return output;
};
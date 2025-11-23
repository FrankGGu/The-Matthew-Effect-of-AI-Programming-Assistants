var maximumLength = function(s) {
    const n = s.length;
    const freq = {};

    for (let i = 0; i < n; ) {
        let j = i;
        while (j < n && s[j] === s[i]) {
            j++;
        }
        const len = j - i;
        const char = s[i];
        if (!freq[char]) {
            freq[char] = [];
        }
        freq[char].push(len);
        i = j;
    }

    let maxLen = -1;

    for (const char in freq) {
        const lengths = freq[char].sort((a, b) => b - a);
        let temp = [];
        for (const len of lengths) {
            for (let k = 1; k <= len; k++) {
                temp.push(k);
            }
        }
        temp.sort((a, b) => b - a);
        const count = {};
        for (const len of temp) {
            count[len] = (count[len] || 0) + 1;
            if (count[len] >= 3) {
                maxLen = Math.max(maxLen, len);
                break;
            }
        }
    }

    return maxLen;
};
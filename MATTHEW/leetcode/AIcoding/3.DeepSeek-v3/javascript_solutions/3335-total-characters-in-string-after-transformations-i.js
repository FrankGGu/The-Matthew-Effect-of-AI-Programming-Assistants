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
        const lengths = freq[char];
        lengths.sort((a, b) => b - a);
        if (lengths.length >= 3) {
            maxLen = Math.max(maxLen, lengths[2]);
        }
        if (lengths.length >= 2) {
            const candidate = Math.min(lengths[0] - 1, lengths[1]);
            if (candidate > 0) {
                maxLen = Math.max(maxLen, candidate);
            }
        }
        if (lengths[0] >= 3) {
            maxLen = Math.max(maxLen, lengths[0] - 2);
        }
    }

    return maxLen === 0 ? -1 : maxLen;
};
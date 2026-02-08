var maximumLength = function(s) {
    const n = s.length;
    const freq = new Map();

    for (let i = 0; i < n; ) {
        let j = i;
        while (j < n && s[j] === s[i]) {
            j++;
        }
        const len = j - i;
        const char = s[i];
        if (!freq.has(char)) {
            freq.set(char, []);
        }
        freq.get(char).push(len);
        i = j;
    }

    let maxLen = -1;

    for (const [char, lengths] of freq) {
        lengths.sort((a, b) => b - a);
        const l = lengths.length;

        if (l >= 3) {
            maxLen = Math.max(maxLen, lengths[2]);
        }
        if (l >= 2) {
            if (lengths[0] >= 2) {
                maxLen = Math.max(maxLen, Math.min(lengths[0] - 1, lengths[1]));
            }
            if (lengths[1] >= 1) {
                maxLen = Math.max(maxLen, lengths[1]);
            }
        }
        if (lengths[0] >= 3) {
            maxLen = Math.max(maxLen, lengths[0] - 2);
        }
    }

    return maxLen === 0 ? -1 : maxLen;
};
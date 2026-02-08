var longestAwesome = function(s) {
    const n = s.length;
    const firstOccurrence = new Array(1024).fill(n);
    firstOccurrence[0] = -1;
    let maxLen = 0;
    let mask = 0;

    for (let i = 0; i < n; i++) {
        const digit = parseInt(s[i]);
        mask ^= (1 << digit);

        maxLen = Math.max(maxLen, i - firstOccurrence[mask]);

        for (let j = 0; j < 10; j++) {
            const tempMask = mask ^ (1 << j);
            maxLen = Math.max(maxLen, i - firstOccurrence[tempMask]);
        }

        if (firstOccurrence[mask] === n) {
            firstOccurrence[mask] = i;
        }
    }

    return maxLen;
};
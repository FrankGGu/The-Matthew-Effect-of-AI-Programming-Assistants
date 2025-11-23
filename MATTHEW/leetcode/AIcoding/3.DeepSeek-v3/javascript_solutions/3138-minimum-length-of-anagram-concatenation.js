var minAnagramLength = function(s) {
    const n = s.length;
    for (let len = 1; len <= n; len++) {
        if (n % len !== 0) continue;
        const freq = new Array(26).fill(0);
        for (let i = 0; i < len; i++) {
            freq[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        }
        let valid = true;
        for (let i = len; i < n; i += len) {
            const currentFreq = new Array(26).fill(0);
            for (let j = i; j < i + len; j++) {
                currentFreq[s.charCodeAt(j) - 'a'.charCodeAt(0)]++;
            }
            if (!freq.every((val, idx) => val === currentFreq[idx])) {
                valid = false;
                break;
            }
        }
        if (valid) return len;
    }
    return n;
};
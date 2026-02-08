var countSubstrings = function(s, k) {
    let count = 0;
    const n = s.length;
    const freq = new Array(26).fill(0);

    for (let i = 0; i < n; i++) {
        let uniqueCount = 0;
        for (let j = i; j < n; j++) {
            const charIndex = s[j].charCodeAt(0) - 'a'.charCodeAt(0);
            if (freq[charIndex] === 0) uniqueCount++;
            freq[charIndex]++;
            if (uniqueCount > k) break;
            count++;
        }
        for (let j = 0; j < 26; j++) freq[j] = 0;
    }

    return count;
};
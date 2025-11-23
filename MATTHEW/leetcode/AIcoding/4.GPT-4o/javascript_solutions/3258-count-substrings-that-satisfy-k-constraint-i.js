var countSubstrings = function(s, k) {
    let count = 0;
    const n = s.length;

    for (let i = 0; i < n; i++) {
        let freq = new Array(26).fill(0);
        let uniqueCount = 0;

        for (let j = i; j < n; j++) {
            const index = s[j].charCodeAt(0) - 'a'.charCodeAt(0);
            if (freq[index] === 0) uniqueCount++;
            freq[index]++;

            if (uniqueCount > k) break;
            count++;
        }
    }

    return count;
};
var beautySum = function(s) {
    let totalBeauty = 0;
    const n = s.length;

    for (let i = 0; i < n; i++) {
        const freq = new Array(26).fill(0);

        for (let j = i; j < n; j++) {
            const charIndex = s.charCodeAt(j) - 'a'.charCodeAt(0);
            freq[charIndex]++;

            let maxFreq = 0;
            let minFreq = Infinity;

            for (let k = 0; k < 26; k++) {
                if (freq[k] > 0) {
                    maxFreq = Math.max(maxFreq, freq[k]);
                    minFreq = Math.min(minFreq, freq[k]);
                }
            }

            totalBeauty += (maxFreq - minFreq);
        }
    }

    return totalBeauty;
};
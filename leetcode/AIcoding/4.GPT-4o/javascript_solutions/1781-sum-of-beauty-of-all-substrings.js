function beautySum(s) {
    let totalBeauty = 0;

    for (let i = 0; i < s.length; i++) {
        let count = Array(26).fill(0);
        let maxFreq = 0;
        let minFreq = Infinity;

        for (let j = i; j < s.length; j++) {
            count[s[j].charCodeAt() - 'a'.charCodeAt()]++;
            maxFreq = Math.max(maxFreq, count[s[j].charCodeAt() - 'a'.charCodeAt()]);
            if (count[s[j].charCodeAt() - 'a'.charCodeAt()] > 0) {
                minFreq = Math.min(minFreq, count[s[j].charCodeAt() - 'a'.charCodeAt()]);
            }
            if (minFreq !== Infinity) {
                totalBeauty += maxFreq - minFreq;
            }
        }
    }

    return totalBeauty;
}
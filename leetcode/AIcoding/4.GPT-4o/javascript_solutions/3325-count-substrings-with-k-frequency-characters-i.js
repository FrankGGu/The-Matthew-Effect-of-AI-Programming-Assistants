function countKSubstrings(s, k) {
    let count = 0;
    const freqMap = new Map();

    for (let i = 0; i < s.length; i++) {
        freqMap.clear();
        let uniqueCount = 0;

        for (let j = i; j < s.length; j++) {
            const char = s[j];
            freqMap.set(char, (freqMap.get(char) || 0) + 1);

            if (freqMap.get(char) === 1) uniqueCount++;
            if (uniqueCount > k) break;
            if (uniqueCount === k) count++;
        }
    }

    return count;
}
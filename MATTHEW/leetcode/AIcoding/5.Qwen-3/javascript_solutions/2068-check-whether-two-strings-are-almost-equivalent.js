function checkAlmostEquivalent(word1, word2) {
    const count = (word) => {
        const freq = {};
        for (const char of word) {
            freq[char] = (freq[char] || 0) + 1;
        }
        return freq;
    };

    const freq1 = count(word1);
    const freq2 = count(word2);

    for (const char in freq1) {
        if (Math.abs(freq1[char] - freq2[char] || 0) > 3) {
            return false;
        }
    }

    for (const char in freq2) {
        if (Math.abs(freq2[char] - freq1[char] || 0) > 3) {
            return false;
        }
    }

    return true;
}
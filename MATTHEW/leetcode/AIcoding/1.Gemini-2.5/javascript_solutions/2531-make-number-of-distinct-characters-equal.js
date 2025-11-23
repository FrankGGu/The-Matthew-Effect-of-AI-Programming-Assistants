function makeEqual(word1, word2) {
    const buildFreq = (word) => {
        const freq = new Array(26).fill(0);
        for (const char of word) {
            freq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
        return freq;
    };

    const countDistinct = (freq) => {
        let count = 0;
        for (let i = 0; i < 26; i++) {
            if (freq[i] > 0) {
                count++;
            }
        }
        return count;
    };

    const freq1 = buildFreq(word1);
    const freq2 = buildFreq(word2);

    for (let i = 0; i < 26; i++) {
        for (let j = 0; j < 26; j++) {
            if (freq1[i] === 0 || freq2[j] === 0) {
                continue;
            }

            const tempFreq1 = [...freq1];
            const tempFreq2 = [...freq2];

            // Simulate character 'a'+i moving from word1 to word2
            // Simulate character 'a'+j moving from word2 to word1

            // Update tempFreq1: 'a'+i leaves, 'a'+j enters
            tempFreq1[i]--;
            tempFreq1[j]++;

            // Update tempFreq2: 'a'+j leaves, 'a'+i enters
            tempFreq2[j]--;
            tempFreq2[i]++;

            if (countDistinct(tempFreq1) === countDistinct(tempFreq2)) {
                return true;
            }
        }
    }

    return false;
}
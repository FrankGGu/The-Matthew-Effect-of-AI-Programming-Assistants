var isItPossible = function(word1, word2) {
    const countDistinct = (word) => {
        const set = new Set();
        for (let char of word) {
            set.add(char);
        }
        return set.size;
    }

    const freq1 = {};
    for (let char of word1) {
        freq1[char] = (freq1[char] || 0) + 1;
    }

    const freq2 = {};
    for (let char of word2) {
        freq2[char] = (freq2[char] || 0) + 1;
    }

    for (let char1 in freq1) {
        for (let char2 in freq2) {
            const newFreq1 = {...freq1};
            const newFreq2 = {...freq2};

            newFreq1[char1]--;
            if (newFreq1[char1] === 0) {
                delete newFreq1[char1];
            }
            newFreq1[char2] = (newFreq1[char2] || 0) + 1;

            newFreq2[char2]--;
            if (newFreq2[char2] === 0) {
                delete newFreq2[char2];
            }
            newFreq2[char1] = (newFreq2[char1] || 0) + 1;

            let distinct1 = Object.keys(newFreq1).length;
            let distinct2 = Object.keys(newFreq2).length;

            if (distinct1 === distinct2) {
                return true;
            }
        }
    }

    return false;
};
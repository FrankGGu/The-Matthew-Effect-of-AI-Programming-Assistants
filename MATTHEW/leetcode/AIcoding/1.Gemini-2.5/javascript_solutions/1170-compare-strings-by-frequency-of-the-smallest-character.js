var numSmallerByFrequency = function(queries, words) {
    const calculateF = (s) => {
        let minChar = 'z';
        let count = 0;

        for (let i = 0; i < s.length; i++) {
            if (s[i] < minChar) {
                minChar = s[i];
                count = 1;
            } else if (s[i] === minChar) {
                count++;
            }
        }
        return count;
    };

    const wordFrequencies = [];
    for (const word of words) {
        wordFrequencies.push(calculateF(word));
    }

    wordFrequencies.sort((a, b) => a - b);

    const results = [];
    for (const query of queries) {
        const queryF = calculateF(query);

        let low = 0;
        let high = wordFrequencies.length - 1;
        let firstGreaterIndex = wordFrequencies.length;

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            if (wordFrequencies[mid] > queryF) {
                firstGreaterIndex = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        results.push(wordFrequencies.length - firstGreaterIndex);
    }

    return results;
};
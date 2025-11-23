var numSmallerByFrequency = function(queries, words) {
    const f = (s) => {
        let minChar = 'z';
        let count = 0;
        for (let char of s) {
            if (char < minChar) {
                minChar = char;
                count = 1;
            } else if (char === minChar) {
                count++;
            }
        }
        return count;
    };

    const wordFrequencies = words.map(word => f(word)).sort((a, b) => a - b);
    const result = [];

    for (const query of queries) {
        const queryFrequency = f(query);
        let count = 0;
        for (const wordFrequency of wordFrequencies) {
            if (queryFrequency < wordFrequency) {
                count++;
            }
        }
        result.push(count);
    }

    return result;
};
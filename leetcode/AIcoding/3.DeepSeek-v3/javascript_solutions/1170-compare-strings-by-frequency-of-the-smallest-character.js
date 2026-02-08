var numSmallerByFrequency = function(queries, words) {
    const f = (s) => {
        const count = new Array(26).fill(0);
        for (const c of s) {
            count[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
        for (let i = 0; i < 26; i++) {
            if (count[i] > 0) {
                return count[i];
            }
        }
        return 0;
    };

    const wordFreqs = words.map(word => f(word));
    wordFreqs.sort((a, b) => a - b);

    const answer = [];
    for (const query of queries) {
        const queryFreq = f(query);
        let left = 0, right = wordFreqs.length;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (wordFreqs[mid] > queryFreq) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        answer.push(wordFreqs.length - left);
    }
    return answer;
};
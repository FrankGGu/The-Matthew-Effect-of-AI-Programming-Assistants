var commonChars = function(words) {
    if (words.length === 0) {
        return [];
    }

    const commonCounts = new Array(26).fill(0);

    for (let i = 0; i < words[0].length; i++) {
        commonCounts[words[0].charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 1; i < words.length; i++) {
        const currentWordCounts = new Array(26).fill(0);
        for (let j = 0; j < words[i].length; j++) {
            currentWordCounts[words[i].charCodeAt(j) - 'a'.charCodeAt(0)]++;
        }

        for (let k = 0; k < 26; k++) {
            commonCounts[k] = Math.min(commonCounts[k], currentWordCounts[k]);
        }
    }

    const result = [];
    for (let i = 0; i < 26; i++) {
        while (commonCounts[i] > 0) {
            result.push(String.fromCharCode('a'.charCodeAt(0) + i));
            commonCounts[i]--;
        }
    }

    return result;
};
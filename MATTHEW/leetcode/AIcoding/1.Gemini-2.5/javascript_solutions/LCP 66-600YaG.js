var minBooths = function(words) {
    const maxFreq = new Array(26).fill(0);

    for (const word of words) {
        const currentWordFreq = new Array(26).fill(0);
        for (const char of word) {
            currentWordFreq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }

        for (let i = 0; i < 26; i++) {
            maxFreq[i] = Math.max(maxFreq[i], currentWordFreq[i]);
        }
    }

    let result = [];
    for (let i = 0; i < 26; i++) {
        const char = String.fromCharCode('a'.charCodeAt(0) + i);
        for (let j = 0; j < maxFreq[i]; j++) {
            result.push(char);
        }
    }

    return result.join('');
};
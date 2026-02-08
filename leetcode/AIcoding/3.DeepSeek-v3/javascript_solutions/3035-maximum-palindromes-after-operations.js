var maxPalindromesAfterOperations = function(words) {
    let freq = new Array(26).fill(0);
    for (let word of words) {
        for (let c of word) {
            freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
    }

    let pairs = 0;
    for (let i = 0; i < 26; i++) {
        pairs += Math.floor(freq[i] / 2);
    }

    let totalLetters = words.reduce((sum, word) => sum + word.length, 0);
    let maxPalindromes = words.length;

    while (maxPalindromes > 0) {
        let requiredPairs = words.slice(0, maxPalindromes).reduce((sum, word) => sum + Math.floor(word.length / 2), 0);
        if (requiredPairs <= pairs) {
            break;
        }
        maxPalindromes--;
    }

    return maxPalindromes;
};
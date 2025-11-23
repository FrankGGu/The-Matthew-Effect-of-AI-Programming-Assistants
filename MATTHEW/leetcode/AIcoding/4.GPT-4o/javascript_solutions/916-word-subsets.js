var wordSubsets = function(A, B) {
    const countB = Array(26).fill(0);

    for (const word of B) {
        const count = Array(26).fill(0);
        for (const char of word) {
            count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
        for (let i = 0; i < 26; i++) {
            countB[i] = Math.max(countB[i], count[i]);
        }
    }

    const result = [];

    for (const word of A) {
        const count = Array(26).fill(0);
        for (const char of word) {
            count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
        let isUniversal = true;
        for (let i = 0; i < 26; i++) {
            if (countB[i] > count[i]) {
                isUniversal = false;
                break;
            }
        }
        if (isUniversal) {
            result.push(word);
        }
    }

    return result;
};
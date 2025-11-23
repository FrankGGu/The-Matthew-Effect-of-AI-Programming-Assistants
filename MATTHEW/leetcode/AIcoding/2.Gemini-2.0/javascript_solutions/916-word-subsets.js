var wordSubsets = function(words1, words2) {
    const bMax = new Array(26).fill(0);

    for (const b of words2) {
        const bFreq = new Array(26).fill(0);
        for (const char of b) {
            bFreq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
        for (let i = 0; i < 26; i++) {
            bMax[i] = Math.max(bMax[i], bFreq[i]);
        }
    }

    const result = [];
    for (const a of words1) {
        const aFreq = new Array(26).fill(0);
        for (const char of a) {
            aFreq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }

        let isUniversal = true;
        for (let i = 0; i < 26; i++) {
            if (aFreq[i] < bMax[i]) {
                isUniversal = false;
                break;
            }
        }

        if (isUniversal) {
            result.push(a);
        }
    }

    return result;
};
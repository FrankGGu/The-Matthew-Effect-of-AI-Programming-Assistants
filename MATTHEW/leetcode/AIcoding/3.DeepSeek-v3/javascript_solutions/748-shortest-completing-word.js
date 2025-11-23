var shortestCompletingWord = function(licensePlate, words) {
    const map = new Array(26).fill(0);
    const a = 'a'.charCodeAt(0);
    for (const c of licensePlate.toLowerCase()) {
        if (c >= 'a' && c <= 'z') {
            map[c.charCodeAt(0) - a]++;
        }
    }

    let result = null;
    for (const word of words) {
        const temp = [...map];
        for (const c of word.toLowerCase()) {
            const index = c.charCodeAt(0) - a;
            if (temp[index] > 0) {
                temp[index]--;
            }
        }
        if (temp.every(count => count === 0)) {
            if (!result || word.length < result.length) {
                result = word;
            }
        }
    }
    return result;
};
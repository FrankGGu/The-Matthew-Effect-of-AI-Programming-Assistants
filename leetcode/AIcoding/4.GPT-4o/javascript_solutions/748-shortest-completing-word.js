var shortestCompletingWord = function(licensePlate, words) {
    const countLetters = (str) => {
        const count = new Array(26).fill(0);
        for (const char of str) {
            const index = char.toLowerCase().charCodeAt(0) - 'a'.charCodeAt(0);
            if (index >= 0 && index < 26) {
                count[index]++;
            }
        }
        return count;
    };

    const licenseCount = countLetters(licensePlate);
    let result = null;

    for (const word of words) {
        const wordCount = countLetters(word);
        let isCompleting = true;

        for (let i = 0; i < 26; i++) {
            if (licenseCount[i] > wordCount[i]) {
                isCompleting = false;
                break;
            }
        }

        if (isCompleting) {
            if (result === null || word.length < result.length) {
                result = word;
            }
        }
    }

    return result;
};
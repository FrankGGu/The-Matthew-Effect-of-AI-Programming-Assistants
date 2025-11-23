function shortestCompletingWords(licensePlate, words) {
    const count = {};
    for (const c of licensePlate) {
        if (c >= 'a' && c <= 'z') {
            count[c] = (count[c] || 0) + 1;
        }
    }

    const result = [];
    for (const word of words) {
        const wordCount = {};
        for (const c of word) {
            if (c >= 'a' && c <= 'z') {
                wordCount[c] = (wordCount[c] || 0) + 1;
            }
        }

        let valid = true;
        for (const key in count) {
            if (!wordCount[key] || wordCount[key] < count[key]) {
                valid = false;
                break;
            }
        }

        if (valid) {
            result.push(word);
        }
    }

    return result.sort((a, b) => a.length - b.length);
}
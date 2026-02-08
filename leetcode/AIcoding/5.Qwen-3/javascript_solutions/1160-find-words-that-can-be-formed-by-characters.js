function countCharacters(words, chars) {
    const charCount = {};
    for (const c of chars) {
        charCount[c] = (charCount[c] || 0) + 1;
    }

    let totalLength = 0;

    for (const word of words) {
        const wordCount = {};
        let canForm = true;

        for (const c of word) {
            wordCount[c] = (wordCount[c] || 0) + 1;
            if (wordCount[c] > (charCount[c] || 0)) {
                canForm = false;
                break;
            }
        }

        if (canForm) {
            totalLength += word.length;
        }
    }

    return totalLength;
}
function wordSubsets(words1, words2) {
    function countChars(s) {
        const count = {};
        for (const c of s) {
            count[c] = (count[c] || 0) + 1;
        }
        return count;
    }

    const maxWord2 = {};
    for (const word of words2) {
        const temp = countChars(word);
        for (const c in temp) {
            if (temp[c] > (maxWord2[c] || 0)) {
                maxWord2[c] = temp[c];
            }
        }
    }

    const result = [];
    for (const word of words1) {
        const wordCount = countChars(word);
        let isSubset = true;
        for (const c in maxWord2) {
            if (wordCount[c] < maxWord2[c]) {
                isSubset = false;
                break;
            }
        }
        if (isSubset) {
            result.push(word);
        }
    }

    return result;
}
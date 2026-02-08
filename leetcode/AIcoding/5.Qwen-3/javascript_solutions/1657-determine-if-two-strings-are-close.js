function closeStrings(word1, word2) {
    if (word1.length !== word2.length) return false;

    const count1 = {};
    const count2 = {};

    for (let c of word1) {
        count1[c] = (count1[c] || 0) + 1;
    }

    for (let c of word2) {
        count2[c] = (count2[c] || 0) + 1;
    }

    const keys1 = Object.keys(count1);
    const keys2 = Object.keys(count2);

    if (keys1.length !== keys2.length) return false;

    for (let i = 0; i < keys1.length; i++) {
        if (!count2[keys1[i]]) return false;
    }

    const values1 = Object.values(count1).sort((a, b) => a - b);
    const values2 = Object.values(count2).sort((a, b) => a - b);

    for (let i = 0; i < values1.length; i++) {
        if (values1[i] !== values2[i]) return false;
    }

    return true;
}
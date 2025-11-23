function areAlmostEquivalent(word1, word2) {
    if (word1.length !== word2.length) return false;

    const count1 = Array(26).fill(0);
    const count2 = Array(26).fill(0);

    for (let i = 0; i < word1.length; i++) {
        count1[word1.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        count2[word2.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    let diffCount = 0;

    for (let i = 0; i < 26; i++) {
        if (Math.abs(count1[i] - count2[i]) > 3) return false;
        if (count1[i] !== count2[i]) diffCount += Math.abs(count1[i] - count2[i]);
    }

    return diffCount <= 6;
}
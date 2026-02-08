var areSentencesSimilar = function(sentence1, sentence2) {
    let words1 = sentence1.split(' ').filter(Boolean);
    let words2 = sentence2.split(' ').filter(Boolean);

    let n1 = words1.length;
    let n2 = words2.length;

    // Ensure words1 is the shorter or equal length sentence
    if (n1 > n2) {
        [words1, words2] = [words2, words1];
        [n1, n2] = [n2, n1];
    }

    // Now n1 <= n2.
    // We need to check if words1 can be formed by removing a contiguous block of words from words2.
    // This means words2 = [prefix] + [middle_block] + [suffix]
    // and words1 = [prefix] + [suffix]

    let i = 0; // Pointer for prefix match
    while (i < n1 && words1[i] === words2[i]) {
        i++;
    }

    let j = 0; // Pointer for suffix match
    // The condition `j < n1 - i` ensures that the suffix match does not overlap with the prefix match
    // within the shorter sentence (words1).
    while (j < n1 - i && words1[n1 - 1 - j] === words2[n2 - 1 - j]) {
        j++;
    }

    // If the total length of the matched prefix and suffix is at least n1,
    // it means all words in words1 are accounted for, implying words1 can be
    // formed by taking words2 and removing a contiguous block in the middle.
    return i + j >= n1;
};
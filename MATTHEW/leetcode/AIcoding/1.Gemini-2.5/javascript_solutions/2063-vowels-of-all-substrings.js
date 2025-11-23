var countVowels = function(word) {
    let totalVowels = 0;
    const n = word.length;
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);

    for (let i = 0; i < n; i++) {
        if (vowels.has(word[i])) {
            // For each vowel at index i, it contributes to (i + 1) * (n - i) substrings.
            // (i + 1) represents the number of possible starting positions for a substring
            // that includes word[i] (from index 0 to i).
            // (n - i) represents the number of possible ending positions for a substring
            // that includes word[i] (from index i to n-1).
            totalVowels += (i + 1) * (n - i);
        }
    }

    return totalVowels;
};
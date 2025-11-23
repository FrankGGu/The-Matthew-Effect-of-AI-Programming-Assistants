var longestPalindrome = function(words) {
    const counts = new Map();
    for (const word of words) {
        counts.set(word, (counts.get(word) || 0) + 1);
    }

    let length = 0;
    let hasOddPalindrome = false;

    // Iterate through the map keys to avoid issues with modifying the array while iterating
    // and to ensure we process each unique word once.
    // Using `for (const [word, count] of counts.entries())` is safer for map iteration.
    // However, the original approach of iterating `words` array and checking `counts.get(word) > 0` also works.
    // Let's stick to the original logic which is common for this problem.
    for (const word of words) {
        if (counts.get(word) === 0) {
            continue;
        }

        const char1 = word[0];
        const char2 = word[1];

        if (char1 === char2) { // Palindromic word like "gg"
            const count = counts.get(word);
            if (count % 2 === 0) {
                length += count * 2;
                counts.set(word, 0); // All instances of this word are used
            } else {
                length += (count - 1) * 2;
                hasOddPalindrome = true;
                counts.set(word, 0); // All but one instance used (the single one is for the center if needed)
            }
        } else { // Non-palindromic word like "lc"
            const reversedWord = char2 + char1;
            if (counts.has(reversedWord) && counts.get(reversedWord) > 0) {
                const countWord = counts.get(word);
                const countReversed = counts.get(reversedWord);
                const pairs = Math.min(countWord, countReversed);
                length += pairs * 4; // Each pair (word, reversedWord) contributes 4 characters
                counts.set(word, countWord - pairs);
                counts.set(reversedWord, countReversed - pairs);
            }
        }
    }

    if (hasOddPalindrome) {
        length += 2; // Add the single middle palindromic word if available
    }

    return length;
};
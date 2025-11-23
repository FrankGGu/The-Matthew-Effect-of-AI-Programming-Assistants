var longestPalindrome = function(words) {
    const freq = new Map();
    for (const word of words) {
        freq.set(word, (freq.get(word) || 0) + 1);
    }

    let ans = 0;
    let hasCenter = false;

    for (const word of freq.keys()) {
        let count = freq.get(word);
        if (count === 0) {
            continue;
        }

        const reverseWord = word[1] + word[0];

        if (word === reverseWord) {
            // Palindromic word like "aa"
            ans += Math.floor(count / 2) * 4;
            if (count % 2 === 1) {
                hasCenter = true;
            }
            freq.set(word, 0); // Mark as fully processed
        } else {
            // Non-palindromic word like "ab"
            const reverseCount = freq.get(reverseWord) || 0;
            if (reverseCount > 0) {
                const pairs = Math.min(count, reverseCount);
                ans += pairs * 4;
                freq.set(word, count - pairs); // Decrement count
                freq.set(reverseWord, reverseCount - pairs); // Decrement reverse word count
            }
        }
    }

    if (hasCenter) {
        ans += 2;
    }

    return ans;
};
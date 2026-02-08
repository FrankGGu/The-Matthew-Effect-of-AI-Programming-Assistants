var longestPalindrome = function(words) {
    const counts = {};
    let ans = 0;
    let center = false;

    for (const word of words) {
        counts[word] = (counts[word] || 0) + 1;
    }

    for (const word in counts) {
        const reversedWord = word[1] + word[0];
        if (word[0] !== word[1]) {
            if (counts[reversedWord]) {
                const minCount = Math.min(counts[word], counts[reversedWord]);
                ans += 4 * minCount;
                counts[word] -= minCount;
                counts[reversedWord] -= minCount;
            }
        } else {
            const count = counts[word];
            ans += 4 * Math.floor(count / 2);
            counts[word] = count % 2;
            if (counts[word] > 0) {
                center = true;
            }
        }
    }

    if (center) {
        ans += 2;
    }

    return ans;
};
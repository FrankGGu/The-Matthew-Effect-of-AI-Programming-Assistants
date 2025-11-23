var longestPalindrome = function(words) {
    const counts = new Map();
    for (const word of words) {
        counts.set(word, (counts.get(word) || 0) + 1);
    }

    let totalLength = 0;
    let hasCentralOddPalindrome = false;

    for (const [word, count] of counts) {
        if (count === 0) {
            continue;
        }

        const reversedWord = word[1] + word[0];

        if (word === reversedWord) {
            totalLength += Math.floor(count / 2) * 4;
            if (count % 2 === 1) {
                hasCentralOddPalindrome = true;
            }
            counts.set(word, 0);
        } else {
            if (counts.has(reversedWord) && counts.get(reversedWord) > 0) {
                const pairs = Math.min(count, counts.get(reversedWord));
                totalLength += pairs * 4;
                counts.set(word, counts.get(word) - pairs);
                counts.set(reversedWord, counts.get(reversedWord) - pairs);
            }
        }
    }

    if (hasCentralOddPalindrome) {
        totalLength += 2;
    }

    return totalLength;
};
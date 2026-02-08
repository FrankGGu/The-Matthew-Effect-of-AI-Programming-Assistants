var longestPalindrome = function(words) {
    const freq = {};
    let result = 0;
    let hasCentral = false;

    for (const word of words) {
        freq[word] = (freq[word] || 0) + 1;
    }

    for (const word of words) {
        if (word[0] === word[1]) {
            const count = freq[word];
            if (count % 2 === 1) {
                hasCentral = true;
            }
            result += Math.floor(count / 2) * 4;
            freq[word] = 0;
        } else {
            const reversed = word[1] + word[0];
            if (freq[reversed] > 0) {
                const min = Math.min(freq[word], freq[reversed]);
                result += min * 4;
                freq[word] = 0;
                freq[reversed] = 0;
            }
        }
    }

    if (hasCentral) {
        result += 2;
    }

    return result;
};
var longestPalindrome = function(words) {
    const counts = {};
    for (const word of words) {
        counts[word] = (counts[word] || 0) + 1;
    }

    let length = 0;
    let hasCenter = false;

    for (const word in counts) {
        const reversed = word[1] + word[0];
        if (counts.hasOwnProperty(reversed)) {
            const count1 = counts[word] || 0;
            const count2 = counts[reversed] || 0;

            if (word === reversed) {
                length += Math.floor(count1 / 2) * 4;
                if (count1 % 2 === 1) {
                    hasCenter = true;
                }
            } else if (word < reversed) {
                length += Math.min(count1, count2) * 4;
            }
        }
    }

    if (hasCenter) {
        length += 2;
    }

    return length;
};
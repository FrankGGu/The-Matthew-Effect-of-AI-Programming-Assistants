var findLongestSpecialSubstring = function(s) {
    const n = s.length;
    let maxLength = 0;

    for (let length = 1; length <= n / 3; length++) {
        const substrings = new Set();
        for (let i = 0; i <= n - length; i++) {
            const substring = s.substring(i, i + length);
            if (substrings.has(substring)) {
                substrings.delete(substring);
            } else {
                substrings.add(substring);
            }
        }

        for (const substring of substrings) {
            let count = 0;
            for (let i = 0; i <= n - length; i++) {
                if (s.substring(i, i + length) === substring) {
                    count++;
                }
            }
            if (count >= 3) {
                maxLength = Math.max(maxLength, length);
            }
        }
    }

    return maxLength;
};
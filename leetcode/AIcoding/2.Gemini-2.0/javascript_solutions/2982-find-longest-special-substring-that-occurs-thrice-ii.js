var longestSpecialSubstring = function(s) {
    let n = s.length;
    let maxLen = 0;

    for (let len = 1; len <= n / 3; len++) {
        let count = 0;
        let seen = new Set();

        for (let i = 0; i <= n - len; i++) {
            let sub = s.substring(i, i + len);
            let isSpecial = true;
            for (let j = 1; j < len; j++) {
                if (sub[j] !== sub[0]) {
                    isSpecial = false;
                    break;
                }
            }

            if (isSpecial && !seen.has(sub)) {
                count++;
                seen.add(sub);
            }
        }

        if (count >= 3) {
            maxLen = len;
        } else {
            break;
        }
    }

    return maxLen;
};
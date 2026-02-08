var longestSpecialSubstring = function(s) {
    let n = s.length;
    let maxLen = -1;

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
            if (isSpecial) {
                if (!seen.has(sub)) {
                    seen.add(sub);
                    let occurrences = 0;
                    for (let k = 0; k <= n - len; k++) {
                        if (s.substring(k, k + len) === sub) {
                            occurrences++;
                        }
                    }
                    if (occurrences >= 3) {
                        maxLen = len;
                        break;
                    }
                }
            }
        }
    }

    return maxLen;
};
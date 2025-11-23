var minLength = function(s) {
    const n = s.length;

    const getCharCounts = (subStr) => {
        const counts = new Array(26).fill(0);
        for (let i = 0; i < subStr.length; i++) {
            counts[subStr.charCodeAt(i) - 97]++;
        }
        return counts;
    };

    const areCountsEqual = (counts1, counts2) => {
        for (let i = 0; i < 26; i++) {
            if (counts1[i] !== counts2[i]) {
                return false;
            }
        }
        return true;
    };

    for (let k = 1; k <= n; k++) {
        if (n % k === 0) {
            const numSubstrings = n / k;

            const firstSub = s.substring(0, k);
            const firstCounts = getCharCounts(firstSub);

            let isValidK = true;
            for (let i = 1; i < numSubstrings; i++) {
                const currentSub = s.substring(i * k, (i + 1) * k);
                const currentCounts = getCharCounts(currentSub);

                if (!areCountsEqual(firstCounts, currentCounts)) {
                    isValidK = false;
                    break;
                }
            }

            if (isValidK) {
                return k;
            }
        }
    }

    return n; 
};
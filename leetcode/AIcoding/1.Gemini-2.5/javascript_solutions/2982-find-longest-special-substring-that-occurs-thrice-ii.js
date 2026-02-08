var longestSpecialSubstring = function(s) {
    const n = s.length;

    const charRuns = new Array(26).fill(0).map(() => []);

    let i = 0;
    while (i < n) {
        let j = i;
        while (j < n && s[j] === s[i]) {
            j++;
        }
        const length = j - i;
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        charRuns[charCode].push(length);
        i = j;
    }

    const check = (k) => {
        if (k <= 0) return true; 
        let totalOccurrences = 0;
        for (let charCode = 0; charCode < 26; charCode++) {
            const lengths = charRuns[charCode];
            for (const L of lengths) {
                totalOccurrences += Math.max(0, L - k + 1);
            }
        }
        return totalOccurrences >= 3;
    };

    let low = 1;
    let high = n;
    let ans = -1;

    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        if (check(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};
var smallestSubstring = function(s, k) {
    let n = s.length;
    let ans = -1;
    for (let len = 1; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            let sub = s.substring(i, i + len);
            let counts = {};
            let valid = true;
            for (let char of sub) {
                counts[char] = (counts[char] || 0) + 1;
            }
            for (let char in counts) {
                if (counts[char] < k) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                ans = len;
                return ans;
            }
        }
    }
    return ans;
};
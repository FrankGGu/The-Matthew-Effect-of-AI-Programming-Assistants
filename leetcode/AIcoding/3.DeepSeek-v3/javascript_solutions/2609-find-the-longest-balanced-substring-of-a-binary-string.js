var findTheLongestBalancedSubstring = function(s) {
    let maxLen = 0;
    let n = s.length;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j += 2) {
            let len = j - i + 1;
            if (len <= maxLen) continue;
            let mid = (i + j) / 2;
            let left = s.substring(i, mid + 1);
            let right = s.substring(mid + 1, j + 1);
            if (left.split('').every(c => c === '0') && right.split('').every(c => c === '1')) {
                maxLen = len;
            }
        }
    }
    return maxLen;
};
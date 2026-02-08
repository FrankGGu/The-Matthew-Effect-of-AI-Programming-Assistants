var countSubstrings = function(s) {
    let count = 0;
    const n = s.length;
    for (let i = 0; i < n; i++) {
        let ones = 0, zeros = 0;
        for (let j = i; j < n; j++) {
            if (s[j] === '1') {
                ones++;
            } else {
                zeros++;
            }
            if (ones > zeros) {
                count++;
            }
        }
    }
    return count;
};
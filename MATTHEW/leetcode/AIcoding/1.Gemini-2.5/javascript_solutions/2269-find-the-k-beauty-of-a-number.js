var divisorSubstrings = function(num, k) {
    let s = num.toString();
    let count = 0;
    for (let i = 0; i <= s.length - k; i++) {
        let sub = s.substring(i, i + k);
        let val = parseInt(sub);
        if (val !== 0 && num % val === 0) {
            count++;
        }
    }
    return count;
};
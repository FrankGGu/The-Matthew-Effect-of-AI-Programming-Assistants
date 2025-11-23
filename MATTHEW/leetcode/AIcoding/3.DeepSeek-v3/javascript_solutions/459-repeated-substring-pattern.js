var repeatedSubstringPattern = function(s) {
    let n = s.length;
    for (let i = 1; i <= n / 2; i++) {
        if (n % i === 0) {
            let pattern = s.substring(0, i);
            let repeated = pattern.repeat(n / i);
            if (repeated === s) {
                return true;
            }
        }
    }
    return false;
};
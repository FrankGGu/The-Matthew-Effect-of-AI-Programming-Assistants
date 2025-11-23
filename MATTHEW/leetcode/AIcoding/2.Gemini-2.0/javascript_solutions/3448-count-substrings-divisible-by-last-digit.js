var countSubstringsDivisibleByLastDigit = function(s) {
    let n = s.length;
    let ans = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            let sub = s.substring(i, j + 1);
            let lastDigit = parseInt(s[j]);
            if (lastDigit === 0) {
                if (parseInt(sub) === 0) {
                    ans++;
                }
            } else if (parseInt(sub) % lastDigit === 0) {
                ans++;
            }
        }
    }
    return ans;
};
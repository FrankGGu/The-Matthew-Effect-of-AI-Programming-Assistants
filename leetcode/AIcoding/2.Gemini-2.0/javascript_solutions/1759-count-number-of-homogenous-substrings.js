var countHomogenous = function(s) {
    let ans = 0;
    let count = 0;
    let mod = 10**9 + 7;

    for (let i = 0; i < s.length; i++) {
        if (i > 0 && s[i] === s[i - 1]) {
            count++;
        } else {
            count = 1;
        }
        ans = (ans + count) % mod;
    }

    return ans;
};
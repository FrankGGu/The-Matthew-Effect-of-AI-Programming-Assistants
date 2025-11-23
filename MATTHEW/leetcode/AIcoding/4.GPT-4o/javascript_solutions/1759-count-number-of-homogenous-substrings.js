var countHomogenous = function(s) {
    const mod = 1e9 + 7;
    let count = 0, current = 1;

    for (let i = 1; i <= s.length; i++) {
        if (i === 0 || s[i] === s[i - 1]) {
            current++;
        } else {
            current = 1;
        }
        count = (count + current) % mod;
    }

    return count;
};
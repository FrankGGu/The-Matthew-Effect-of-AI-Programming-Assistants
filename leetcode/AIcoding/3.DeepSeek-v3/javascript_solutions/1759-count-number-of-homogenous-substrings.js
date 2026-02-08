var countHomogenous = function(s) {
    const MOD = 1e9 + 7;
    let res = 0;
    let currentChar = '';
    let currentLength = 0;

    for (const char of s) {
        if (char === currentChar) {
            currentLength++;
        } else {
            currentChar = char;
            currentLength = 1;
        }
        res = (res + currentLength) % MOD;
    }

    return res;
};
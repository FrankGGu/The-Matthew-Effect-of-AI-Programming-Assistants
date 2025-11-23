function numberOfUniqueGoodSubsequences(s) {
    let hasZero = false;
    let hasOne = false;
    let dp = 0;
    let count = 0;

    for (let c of s) {
        if (c === '0') {
            hasZero = true;
            count = (count + dp) % (10**9 + 7);
        } else {
            hasOne = true;
            dp = (dp + 1) % (10**9 + 7);
        }
    }

    return (count + (hasOne ? 1 : 0)) % (10**9 + 7);
}
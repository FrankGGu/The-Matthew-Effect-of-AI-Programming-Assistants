function findSubstringInWraporedString(p) {
    const dp = new Array(26).fill(0);
    let count = 0;

    for (let i = 0; i < p.length; i++) {
        if (i > 0 && (p.charCodeAt(i) - p.charCodeAt(i - 1) === 1 || p.charCodeAt(i - 1) - p.charCodeAt(i) === 25)) {
            count++;
        } else {
            count = 1;
        }

        const index = p.charCodeAt(i) - 'a'.charCodeAt(0);
        if (count > dp[index]) {
            dp[index] = count;
        }
    }

    return dp.reduce((sum, val) => sum + val, 0);
}
var atMostNGivenDigitSet = function(digits, n) {
    const nStr = String(n);
    const L = nStr.length;
    const D = digits.length;
    let ans = 0;

    // Count numbers with fewer digits than N
    for (let i = 1; i < L; i++) {
        ans += Math.pow(D, i);
    }

    // Count numbers with the same number of digits as N
    for (let i = 0; i < L; i++) {
        let s = nStr[i];
        let foundSame = false;
        for (let d of digits) {
            if (d < s) {
                ans += Math.pow(D, L - 1 - i);
            } else if (d === s) {
                foundSame = true;
                break; // Found the current digit, continue to the next position
            }
        }
        if (!foundSame) {
            // If the current digit of N is not in 'digits',
            // we cannot form N or any number starting with the current prefix
            // that is equal to N's prefix up to this point.
            // So, we stop and return the current count.
            return ans;
        }
    }

    // If the loop completes, it means N itself can be formed using the given digits.
    // So, we add N to the count.
    ans++;
    return ans;
};
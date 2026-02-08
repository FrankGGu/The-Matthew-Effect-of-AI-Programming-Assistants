var atMostNGivenDigitSet = function(digits, n) {
    const s = String(n);
    const k = s.length;
    let ans = 0;

    for (let i = 1; i < k; ++i) {
        ans += Math.pow(digits.length, i);
    }

    for (let i = 0; i < k; ++i) {
        let hasSameNum = false;
        for (const d of digits) {
            if (d[0] < s[i]) {
                ans += Math.pow(digits.length, k - i - 1);
            } else if (d[0] === s[i]) {
                hasSameNum = true;
                if (i === k - 1) {
                    ans++;
                }
                break;
            }
        }
        if (!hasSameNum) {
            return ans;
        }
    }

    return ans;
};
var numDupDigitsAtMostN = function(n) {
    const s = String(n);
    const len = s.length;
    let ans = 0;

    for (let i = 1; i < len; i++) {
        ans += 9 * A(9, i - 1);
    }

    let seen = new Set();
    for (let i = 0; i < len; i++) {
        for (let j = (i === 0 ? 1 : 0); j < Number(s[i]); j++) {
            if (!seen.has(j)) {
                ans += A(9 - i, len - i - 1);
            }
        }

        if (seen.has(Number(s[i]))) {
            break;
        }

        seen.add(Number(s[i]));

        if (i === len - 1) {
            ans++;
        }
    }

    return n - ans;

    function A(m, n) {
        let res = 1;
        for (let i = 0; i < n; i++) {
            res *= (m - i);
        }
        return res;
    }
};
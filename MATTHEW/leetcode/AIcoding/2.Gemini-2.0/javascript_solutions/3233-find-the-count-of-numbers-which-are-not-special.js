var countSpecialNumbers = function(n) {
    const s = String(n);
    const len = s.length;
    let ans = 0;

    function A(m, n) {
        let res = 1;
        for (let i = 0; i < n; i++) {
            res *= (m - i);
        }
        return res;
    }

    for (let i = 1; i < len; i++) {
        ans += 9 * A(9, i - 1);
    }

    let seen = new Set();
    for (let i = 0; i < len; i++) {
        let digit = Number(s[i]);
        for (let j = (i === 0 ? 1 : 0); j < digit; j++) {
            if (!seen.has(j)) {
                ans += A(10 - (i + 1), len - i - 1);
            }
        }
        if (seen.has(digit)) {
            break;
        }
        seen.add(digit);
        if (i === len - 1) {
            ans++;
        }
    }

    return n - ans;
};
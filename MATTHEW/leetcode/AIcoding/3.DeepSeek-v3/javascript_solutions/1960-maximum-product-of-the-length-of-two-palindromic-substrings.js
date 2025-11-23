var maxProduct = function(s) {
    const n = s.length;
    const isPal = Array(n).fill().map(() => Array(n).fill(false));
    for (let i = 0; i < n; i++) {
        isPal[i][i] = true;
    }
    for (let i = 0; i < n - 1; i++) {
        if (s[i] === s[i + 1]) {
            isPal[i][i + 1] = true;
        }
    }
    for (let len = 3; len <= n; len++) {
        for (let i = 0; i + len - 1 < n; i++) {
            const j = i + len - 1;
            if (s[i] === s[j] && isPal[i + 1][j - 1]) {
                isPal[i][j] = true;
            }
        }
    }
    const left = Array(n).fill(0);
    left[0] = 1;
    for (let i = 1; i < n; i++) {
        left[i] = left[i - 1];
        for (let j = 0; j <= i; j++) {
            if (isPal[j][i]) {
                left[i] = Math.max(left[i], i - j + 1);
            }
        }
    }
    const right = Array(n).fill(0);
    right[n - 1] = 1;
    for (let i = n - 2; i >= 0; i--) {
        right[i] = right[i + 1];
        for (let j = n - 1; j >= i; j--) {
            if (isPal[i][j]) {
                right[i] = Math.max(right[i], j - i + 1);
            }
        }
    }
    let res = 0;
    for (let i = 0; i < n - 1; i++) {
        res = Math.max(res, left[i] * right[i + 1]);
    }
    return res;
};
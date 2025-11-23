var shortestToChar = function(s, c) {
    const n = s.length;
    const ans = new Array(n).fill(Infinity);

    let prevCIndex = -Infinity;
    for (let i = 0; i < n; i++) {
        if (s[i] === c) {
            prevCIndex = i;
        }
        ans[i] = Math.min(ans[i], i - prevCIndex);
    }

    prevCIndex = Infinity;
    for (let i = n - 1; i >= 0; i--) {
        if (s[i] === c) {
            prevCIndex = i;
        }
        ans[i] = Math.min(ans[i], prevCIndex - i);
    }

    return ans;
};
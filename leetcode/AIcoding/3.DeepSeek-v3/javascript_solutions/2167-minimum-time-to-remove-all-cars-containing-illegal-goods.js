var minimumTime = function(s) {
    const n = s.length;
    let left = 0;
    let res = n;
    for (let i = 0; i < n; i++) {
        left = Math.min(left + (s[i] === '1' ? 2 : 0), i + 1);
        res = Math.min(res, left + n - 1 - i);
    }
    return res;
};
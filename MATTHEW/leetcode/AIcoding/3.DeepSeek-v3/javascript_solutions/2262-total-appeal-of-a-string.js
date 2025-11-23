var appealSum = function(s) {
    let last = new Array(26).fill(-1);
    let res = 0, n = s.length;
    for (let i = 0; i < n; ++i) {
        let c = s.charCodeAt(i) - 'a'.charCodeAt(0);
        res += (i - last[c]) * (n - i);
        last[c] = i;
    }
    return res;
};
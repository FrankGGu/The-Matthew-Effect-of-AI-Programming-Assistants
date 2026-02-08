var appealSum = function(s) {
    let n = s.length;
    let last = new Array(26).fill(-1);
    let ans = 0;
    for (let i = 0; i < n; i++) {
        let c = s.charCodeAt(i) - 'a'.charCodeAt(0);
        ans += (i - last[c]) * (n - i);
        last[c] = i;
    }
    return ans;
};
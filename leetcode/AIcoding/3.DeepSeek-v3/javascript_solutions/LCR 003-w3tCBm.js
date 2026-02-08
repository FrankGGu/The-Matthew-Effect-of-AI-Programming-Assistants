var countBits = function(n) {
    let ans = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        ans[i] = ans[i & (i - 1)] + 1;
    }
    return ans;
};
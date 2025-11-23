var countOfPairs = function(n, x, y) {
    let ans = new Array(n).fill(0);
    for (let i = 1; i <= n; i++) {
        for (let j = i + 1; j <= n; j++) {
            let direct = Math.abs(i - j);
            let via = Math.abs(i - x) + 1 + Math.abs(y - j);
            let via2 = Math.abs(i - y) + 1 + Math.abs(x - j);
            let dist = Math.min(direct, via, via2);
            ans[dist - 1] += 2;
        }
    }
    return ans;
};
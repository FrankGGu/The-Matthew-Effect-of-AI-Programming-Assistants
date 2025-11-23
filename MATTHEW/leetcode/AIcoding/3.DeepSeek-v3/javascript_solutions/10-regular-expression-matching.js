var isMatch = function(s, p) {
    const memo = new Map();

    function dp(i, j) {
        if (memo.has(`${i},${j}`)) {
            return memo.get(`${i},${j}`);
        }

        if (j === p.length) {
            return i === s.length;
        }

        const firstMatch = i < s.length && (p[j] === s[i] || p[j] === '.');

        let ans;
        if (j + 1 < p.length && p[j + 1] === '*') {
            ans = dp(i, j + 2) || (firstMatch && dp(i + 1, j));
        } else {
            ans = firstMatch && dp(i + 1, j + 1);
        }

        memo.set(`${i},${j}`, ans);
        return ans;
    }

    return dp(0, 0);
};
var recoverArray = function(n, sums) {
    sums.sort((a, b) => a - b);
    const res = [];
    const dfs = (s, k) => {
        if (s.length === 1) return true;
        const d = s[1] - s[0];
        const left = [], right = [];
        const count = new Map();
        for (const num of s) {
            count.set(num, (count.get(num) || 0) + 1);
        }
        let valid = false;
        for (const num of s) {
            if (count.get(num) === 0) continue;
            if (count.get(num - d) === 0) {
                valid = false;
                break;
            }
            left.push(num - d);
            right.push(num);
            count.set(num, count.get(num) - 1);
            count.set(num - d, count.get(num - d) - 1);
            valid = true;
        }
        if (valid) {
            res.push(d);
            if (dfs(left, k + 1)) return true;
            res.pop();
        }
        res.push(-d);
        if (dfs(right, k + 1)) return true;
        res.pop();
        return false;
    };
    dfs(sums, 0);
    return res;
};
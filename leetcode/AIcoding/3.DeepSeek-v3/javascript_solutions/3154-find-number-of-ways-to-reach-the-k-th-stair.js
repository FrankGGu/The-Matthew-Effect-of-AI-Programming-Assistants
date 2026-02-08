var waysToReachStair = function(k) {
    let memo = new Map();

    function dfs(current, jump, isPrevBack) {
        if (current > k + 1) return 0;
        if (current === k) {
            let res = 1;
            if (!isPrevBack && current - 1 >= 0) {
                res += dfs(current - 1, jump, true);
            }
            return res;
        }

        const key = `${current},${jump},${isPrevBack}`;
        if (memo.has(key)) return memo.get(key);

        let total = 0;
        if (!isPrevBack && current - 1 >= 0) {
            total += dfs(current - 1, jump, true);
        }
        total += dfs(current + (1 << jump), jump + 1, false);

        memo.set(key, total);
        return total;
    }

    return dfs(1, 0, false);
};
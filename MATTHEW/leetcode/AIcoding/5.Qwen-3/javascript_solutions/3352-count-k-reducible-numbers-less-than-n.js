function countKReducibleNumbers(n, k) {
    const dp = new Set();
    const visited = new Set();

    function dfs(num) {
        if (num <= 1 || visited.has(num)) return;
        visited.add(num);
        let next = num;
        for (let i = 0; i < k; i++) {
            next = Math.floor(next / 2);
        }
        if (next >= 1) {
            dp.add(num);
            dfs(next);
        }
    }

    for (let i = 2; i <= n; i++) {
        dfs(i);
    }

    return dp.size;
}
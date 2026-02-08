var lexicalOrder = function(n) {
    const result = [];
    const dfs = (curr) => {
        if (curr > n) return;
        result.push(curr);
        for (let i = 0; i < 10; i++) {
            dfs(curr * 10 + i);
        }
    };
    for (let i = 1; i <= 9; i++) {
        dfs(i);
    }
    return result.filter(num => num <= n);
};
var tilingRectangle = function(n, m) {
    if (n === m) return 1;
    let memo = {};

    const dfs = (width, height) => {
        if (width === height) return 1;
        if (width === 0 || height === 0) return 0;
        if (width > height) {
            [width, height] = [height, width];
        }
        const key = `${width},${height}`;
        if (memo[key] !== undefined) return memo[key];

        let res = Infinity;
        for (let i = 1; i <= width; i++) {
            const option1 = dfs(width - i, height) + dfs(i, height - i);
            const option2 = dfs(width, height - i) + dfs(width - i, i);
            res = Math.min(res, option1, option2);
        }
        memo[key] = res + 1;
        return memo[key];
    };

    return dfs(n, m);
};
var numberOfWays = function(n, queries) {
    const result = [];
    for (const query of queries) {
        let count = 0;
        for (let i = 1; i <= n; i++) {
            if (i >= query[0] && i <= query[1]) {
                count++;
            }
        }
        result.push(count);
    }
    return result;
};
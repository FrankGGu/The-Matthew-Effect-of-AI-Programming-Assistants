var substringXorQueries = function(S, queries) {
    const result = [];
    const n = S.length;

    for (const [x, y] of queries) {
        let found = false;
        for (let len = 1; len <= 30; len++) {
            const mask = (1 << len) - 1;
            for (let i = 0; i <= n - len; i++) {
                const num = parseInt(S.substr(i, len), 2);
                if (num === x) {
                    const start = i;
                    const end = i + len - 1;
                    result.push([start, end]);
                    found = true;
                    break;
                }
            }
            if (found) break;
        }
        if (!found) result.push([-1, -1]);
    }

    return result;
};
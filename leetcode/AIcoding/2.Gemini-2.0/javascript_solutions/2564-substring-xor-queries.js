var substringXorQueries = function(s, queries) {
    const n = s.length;
    const result = [];
    for (const query of queries) {
        const first = query[0];
        const second = query[1];
        const target = first ^ second;
        let found = false;
        for (let len = 1; len <= n; len++) {
            for (let i = 0; i <= n - len; i++) {
                const sub = s.substring(i, i + len);
                if (parseInt(sub, 2) === target) {
                    result.push([i, i + len - 1]);
                    found = true;
                    break;
                }
                if (isNaN(parseInt(sub, 2))) continue;
                if (parseInt(sub, 2) > target) continue;

            }
            if (found) break;
        }
        if (!found) {
            result.push([-1, -1]);
        }
    }
    return result;
};
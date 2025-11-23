var crackSafe = function(n, k) {
    const visited = new Set();
    const path = [];

    const initialPrefix = '0'.repeat(n - 1);

    function dfs(u) {
        for (let d = k - 1; d >= 0; d--) {
            const digit = String(d);
            const edgeCode = u + digit;

            if (!visited.has(edgeCode)) {
                visited.add(edgeCode);

                let next_u;
                if (n === 1) {
                    next_u = '';
                } else {
                    next_u = u.substring(1) + digit;
                }

                dfs(next_u);
                path.push(digit);
            }
        }
    }

    dfs(initialPrefix);

    return initialPrefix + path.reverse().join('');
};
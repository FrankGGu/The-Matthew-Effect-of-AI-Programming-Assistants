var crackSafe = function(n, k) {
    const visited = new Set();
    let result = [];

    const dfs = (node) => {
        for (let i = 0; i < k; i++) {
            const neighbor = node + i;
            if (!visited.has(neighbor)) {
                visited.add(neighbor);
                dfs(neighbor.slice(1));
                result.push(i);
            }
        }
    };

    const start = '0'.repeat(n - 1);
    dfs(start);
    result.push(start);
    return result.join('');
};
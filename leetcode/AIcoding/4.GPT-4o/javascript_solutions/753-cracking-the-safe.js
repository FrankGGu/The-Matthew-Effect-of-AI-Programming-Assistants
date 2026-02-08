function crackSafe(n, k) {
    const result = [];
    const visited = new Set();
    const totalCombinations = Math.pow(k, n);
    const initial = '0'.repeat(n);

    function dfs(node) {
        for (let i = 0; i < k; i++) {
            const nextNode = node + i;
            if (!visited.has(nextNode)) {
                visited.add(nextNode);
                dfs(nextNode.slice(1));
                result.push(i);
            }
        }
    }

    visited.add(initial);
    dfs(initial);
    result.push(0); // Start with '0' to complete the first lock
    return result.reverse().join('');
}
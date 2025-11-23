var crackSafe = function(n, k) {
    const total = Math.pow(k, n);
    let visited = new Set();
    let ans = "";

    function dfs(node) {
        for (let i = 0; i < k; i++) {
            let nextNode = node.slice(1) + i;
            if (!visited.has(nextNode)) {
                visited.add(nextNode);
                dfs(nextNode);
                ans += i;
            }
        }
    }

    let start = "0".repeat(n - 1);
    visited.add(start);
    dfs(start);

    return ans + start;
};
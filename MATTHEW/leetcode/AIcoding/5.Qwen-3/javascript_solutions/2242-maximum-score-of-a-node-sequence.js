function maximumScore(nums, edges) {
    const n = nums.length;
    const adj = Array.from({ length: n }, () => []);

    for (let i = 0; i < n - 1; i++) {
        const [u, v] = edges[i];
        adj[u].push(v);
        adj[v].push(u);
    }

    let maxScore = -1;

    function dfs(node, parent) {
        const values = [];
        for (const neighbor of adj[node]) {
            if (neighbor !== parent) {
                values.push(dfs(neighbor, node));
            }
        }
        values.sort((a, b) => b - a);
        let score = nums[node];
        if (values.length >= 2) {
            score += values[0] + values[1];
        } else if (values.length === 1) {
            score += values[0];
        }
        maxScore = Math.max(maxScore, score);
        return nums[node];
    }

    dfs(0, -1);
    return maxScore;
}
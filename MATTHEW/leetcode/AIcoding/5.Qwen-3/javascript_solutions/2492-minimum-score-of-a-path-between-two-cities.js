function minScore(nums, edges) {
    const n = nums.length;
    const graph = Array.from({ length: n }, () => []);

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            graph[i].push([j, nums[i] ^ nums[j]]);
            graph[j].push([i, nums[i] ^ nums[j]]);
        }
    }

    const visited = new Array(n).fill(false);
    const minScore = { value: Infinity };

    function dfs(node, currentScore) {
        visited[node] = true;
        minScore.value = Math.min(minScore.value, currentScore);

        for (const [neighbor, score] of graph[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor, currentScore);
            }
        }
    }

    dfs(0, 0);

    return minScore.value;
}
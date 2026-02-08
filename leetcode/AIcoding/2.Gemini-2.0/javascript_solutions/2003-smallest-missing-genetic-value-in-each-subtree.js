var smallestMissingValueSubtree = function(parents, nums) {
    const n = parents.length;
    const adj = Array(n).fill(null).map(() => []);
    for (let i = 1; i < n; i++) {
        adj[parents[i]].push(i);
    }

    let oneIndex = -1;
    for (let i = 0; i < n; i++) {
        if (nums[i] === 1) {
            oneIndex = i;
            break;
        }
    }

    if (oneIndex === -1) {
        return Array(n).fill(1);
    }

    const ans = Array(n).fill(1);
    let missing = 1;
    let visited = new Set();
    let curr = oneIndex;

    while (curr !== -1) {
        dfs(curr, adj, nums, visited);
        while (visited.has(missing)) {
            missing++;
        }
        ans[curr] = missing;
        curr = parents[curr];
    }

    return ans;

    function dfs(node, adj, nums, visited) {
        if (visited.has(nums[node])) {
            return;
        }
        visited.add(nums[node]);
        for (const neighbor of adj[node]) {
            dfs(neighbor, adj, nums, visited);
        }
    }
};
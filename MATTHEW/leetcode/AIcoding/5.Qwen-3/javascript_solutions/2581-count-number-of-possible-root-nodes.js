function possibleRootNodes(parent, nums) {
    const n = parent.length;
    const graph = new Array(n).fill(0).map(() => []);
    for (let i = 1; i < n; i++) {
        graph[parent[i]].push(i);
    }

    const count = new Array(n).fill(0);

    function dfs(node) {
        let res = 1;
        for (const child of graph[node]) {
            res += dfs(child);
        }
        count[node] = res;
        return res;
    }

    dfs(0);

    const set = new Set(nums);
    const result = [];

    for (let i = 0; i < n; i++) {
        if (set.has(count[i])) {
            result.push(i);
        }
    }

    return result;
}
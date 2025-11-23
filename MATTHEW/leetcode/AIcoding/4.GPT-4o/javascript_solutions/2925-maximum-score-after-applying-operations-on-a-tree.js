var maxScore = function(parents, nums) {
    const n = nums.length;
    const tree = Array.from({ length: n }, () => []);
    for (let i = 1; i < n; i++) {
        tree[parents[i]].push(i);
    }

    const dfs = (node) => {
        let total = nums[node];
        let maxChild = 0;
        for (const child of tree[node]) {
            const childScore = dfs(child);
            maxChild = Math.max(maxChild, childScore);
            total += childScore;
        }
        return total;
    };

    let maxScore = 0;
    const dfsMax = (node) => {
        let total = nums[node];
        for (const child of tree[node]) {
            total += dfsMax(child);
        }
        maxScore = Math.max(maxScore, total);
        return total;
    };

    dfsMax(0);
    return maxScore;
};
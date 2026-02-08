var componentValue = function(nums, edges) {
    const n = nums.length;
    const totalSum = nums.reduce((a, b) => a + b, 0);
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const dfs = (u, parent, target, sum) => {
        let currentSum = nums[u];
        for (const v of graph[u]) {
            if (v === parent) continue;
            const childSum = dfs(v, u, target, sum);
            if (childSum === -1) return -1;
            currentSum += childSum;
        }
        if (currentSum > target) return -1;
        return currentSum === target ? 0 : currentSum;
    };

    let maxK = 0;
    for (let k = 1; k <= totalSum; k++) {
        if (totalSum % k !== 0) continue;
        const target = totalSum / k;
        if (dfs(0, -1, target, 0) === 0) {
            maxK = Math.max(maxK, k);
        }
    }

    return maxK - 1;
};
var smallestMissingValueSubtree = function(parents, nums) {
    const n = parents.length;
    const children = Array.from({ length: n }, () => []);
    for (let i = 1; i < n; i++) {
        children[parents[i]].push(i);
    }

    const res = new Array(n).fill(1);
    const visited = new Set();

    const dfs = (node) => {
        if (visited.has(nums[node])) return;
        visited.add(nums[node]);
        for (const child of children[node]) {
            dfs(child);
        }
    };

    let node = -1;
    for (let i = 0; i < n; i++) {
        if (nums[i] === 1) {
            node = i;
            break;
        }
    }

    if (node === -1) return res;

    let missing = 1;
    while (node !== -1) {
        dfs(node);
        while (visited.has(missing)) {
            missing++;
        }
        res[node] = missing;
        node = parents[node];
    }

    return res;
};
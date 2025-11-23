var smallestMissingValueSubtree = function(parents, nums) {
    const n = parents.length;
    const children = new Array(n).fill(0).map(() => []);
    for (let i = 1; i < n; i++) {
        children[parents[i]].push(i);
    }

    const res = new Array(n).fill(1);
    const visited = new Set();
    let node = nums.indexOf(1);
    let missing = 1;

    while (node !== -1) {
        dfs(node, children, nums, visited);
        while (visited.has(missing)) {
            missing++;
        }
        res[node] = missing;
        node = parents[node];
    }

    return res;
};

function dfs(node, children, nums, visited) {
    if (visited.has(nums[node])) {
        return;
    }
    visited.add(nums[node]);
    for (const child of children[node]) {
        dfs(child, children, nums, visited);
    }
}
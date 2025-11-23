var gcdTraversal = function(nums) {
    const n = nums.length;
    const graph = new Map();

    for (let i = 0; i < n; i++) {
        if (!graph.has(nums[i])) {
            graph.set(nums[i], []);
        }
        for (let j = 0; j < n; j++) {
            if (i !== j && gcd(nums[i], nums[j]) > 1) {
                graph.get(nums[i]).push(nums[j]);
                graph.get(nums[j]).push(nums[i]);
            }
        }
    }

    const visited = new Set();
    const dfs = (node) => {
        visited.add(node);
        for (const neighbor of graph.get(node)) {
            if (!visited.has(neighbor)) {
                dfs(neighbor);
            }
        }
    };

    dfs(nums[0]);

    for (const num of nums) {
        if (!visited.has(num)) {
            return false;
        }
    }
    return true;
};

function gcd(a, b) {
    while (b) {
        [a, b] = [b, a % b];
    }
    return a;
}
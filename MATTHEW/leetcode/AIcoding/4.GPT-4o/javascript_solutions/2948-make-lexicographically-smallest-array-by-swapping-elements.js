var smallestArray = function(nums, swaps) {
    const n = nums.length;
    const parent = Array.from({ length: n }, (_, i) => i);

    const find = (x) => {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    };

    const union = (x, y) => {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            parent[rootY] = rootX;
        }
    };

    for (const [a, b] of swaps) {
        union(a, b);
    }

    const groups = {};
    for (let i = 0; i < n; i++) {
        const root = find(i);
        if (!groups[root]) {
            groups[root] = [];
        }
        groups[root].push(nums[i]);
    }

    for (const key in groups) {
        groups[key].sort();
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        const root = find(i);
        result[i] = groups[root].shift();
    }

    return result;
};
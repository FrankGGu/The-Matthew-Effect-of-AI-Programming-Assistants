function equationsPossible(nums) {
    const parent = {};

    function find(x) {
        if (!parent[x]) {
            parent[x] = x;
        }
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        parent[find(x)] = find(y);
    }

    for (const [a, op, b] of nums) {
        if (op === "=") {
            union(a, b);
        }
    }

    for (const [a, op, b] of nums) {
        if (op === "!") {
            if (find(a) === find(b)) {
                return false;
            }
        }
    }

    return true;
}
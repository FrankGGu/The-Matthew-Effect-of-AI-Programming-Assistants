class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var verticalTraversal = function(root) {
    const map = new Map();

    const dfs = (node, x, y) => {
        if (!node) return;
        if (!map.has(x)) map.set(x, []);
        map.get(x).push([y, node.val]);
        dfs(node.left, x - 1, y + 1);
        dfs(node.right, x + 1, y + 1);
    };

    dfs(root, 0, 0);

    const result = [];
    const keys = Array.from(map.keys()).sort((a, b) => a - b);

    for (const key of keys) {
        const values = map.get(key);
        values.sort((a, b) => a[0] === b[0] ? a[1] - b[1] : a[0] - b[0]);
        result.push(values.map(v => v[1]));
    }

    return result;
};
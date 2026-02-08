class TreeNode {
    constructor(val = 0, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var findSubtreeSizes = function(root, queries) {
    const sizeMap = new Map();

    const dfs = (node) => {
        if (!node) return 0;
        const leftSize = dfs(node.left);
        const rightSize = dfs(node.right);
        const totalSize = 1 + leftSize + rightSize;
        sizeMap.set(node, totalSize);
        return totalSize;
    };

    dfs(root);

    return queries.map(q => sizeMap.get(q));
};
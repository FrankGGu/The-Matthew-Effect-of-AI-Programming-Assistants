var treeQueries = function(root, queries) {
    const heights = new Map();
    const maxHeight = (node) => {
        if (!node) return -1;
        const left = maxHeight(node.left);
        const right = maxHeight(node.right);
        const height = Math.max(left, right) + 1;
        heights.set(node.val, height);
        return height;
    };

    const dfs = (node, parentHeight) => {
        if (!node) return;
        const currentHeight = heights.get(node.val);
        const leftHeight = node.left ? heights.get(node.left.val) : -1;
        const rightHeight = node.right ? heights.get(node.right.val) : -1;
        const maxChildHeight = Math.max(leftHeight, rightHeight);
        maxHeightResults[node.val] = Math.max(parentHeight, maxChildHeight) + 1;
        dfs(node.left, maxHeightResults[node.val]);
        dfs(node.right, maxHeightResults[node.val]);
    };

    const maxHeightResults = {};
    maxHeight(root);
    dfs(root, -1);

    return queries.map(q => maxHeightResults[q]);
};
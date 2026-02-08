class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var colorBinaryTree = function(root) {
    if (!root) return [];

    const result = [];

    function traverse(node, color) {
        if (!node) return;
        result.push([node.val, color]);
        traverse(node.left, color);
        traverse(node.right, color);
    }

    traverse(root, 'Red');

    return result;
};
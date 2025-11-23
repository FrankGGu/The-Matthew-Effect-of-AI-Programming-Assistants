function TreeNode(val, left, right) {
    this.val = val === undefined ? 0 : val;
    this.left = left === undefined ? null : left;
    this.right = right === undefined ? null : right;
}

function sumEvenGrandparent(root) {
    let total = 0;

    function dfs(node, parent, grandParent) {
        if (grandParent && grandParent.val % 2 === 0) {
            total += node.val;
        }
        if (node.left) {
            dfs(node.left, node, parent);
        }
        if (node.right) {
            dfs(node.right, node, parent);
        }
    }

    if (root) {
        dfs(root, null, null);
    }

    return total;
}
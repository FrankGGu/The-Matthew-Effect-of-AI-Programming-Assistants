function TreeNode(val) {
    this.val = val;
    this.left = null;
    this.right = null;
}

var preorderTraversal = function(root) {
    var result = [];
    var stack = [];
    if (root === null) return result;
    stack.push(root);
    while (stack.length > 0) {
        var node = stack.pop();
        result.push(node.val);
        if (node.right !== null) {
            stack.push(node.right);
        }
        if (node.left !== null) {
            stack.push(node.left);
        }
    }
    return result;
};
function isSubPath(head, root) {
    function dfs(node, head) {
        if (!head) return true;
        if (!node) return false;
        return (node.val === head.val && (dfs(node.left, head.next) || dfs(node.right, head.next)));
    }

    function traverse(node) {
        if (!node) return false;
        return dfs(node, head) || traverse(node.left) || traverse(node.right);
    }

    return traverse(root);
}
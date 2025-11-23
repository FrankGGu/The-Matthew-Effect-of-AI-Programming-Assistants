var isSubPath = function(head, root) {
    if (!head) return true;
    if (!root) return false;

    function dfs(node, head) {
        if (!head) return true;
        if (!node) return false;

        if (node.val === head.val) {
            if (dfs(node.left, head.next) || dfs(node.right, head.next)) {
                return true;
            }
        }
        return false;
    }

    function traverse(node, head) {
        if (!node) return false;

        if (node.val === head.val && dfs(node, head)) {
            return true;
        }

        return traverse(node.left, head) || traverse(node.right, head);
    }

    return traverse(root, head);
};
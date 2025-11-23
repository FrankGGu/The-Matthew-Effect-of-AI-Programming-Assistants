var isSubPath = function(head, root) {
    const dfs = (listNode, treeNode) => {
        if (!listNode) return true;
        if (!treeNode) return false;
        if (treeNode.val !== listNode.val) return false;
        return dfs(listNode.next, treeNode.left) || dfs(listNode.next, treeNode.right);
    };

    if (!head) return true;
    if (!root) return false;
    return dfs(head, root) || isSubPath(head, root.left) || isSubPath(head, root.right);
};
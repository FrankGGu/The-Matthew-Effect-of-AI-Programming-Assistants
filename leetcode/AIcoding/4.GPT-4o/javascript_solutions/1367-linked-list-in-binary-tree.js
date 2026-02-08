class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

class ListNode {
    constructor(val, next = null) {
        this.val = val;
        this.next = next;
    }
}

var isSubPath = function(head, root) {
    const dfs = (node, listNode) => {
        if (!listNode) return true;
        if (!node) return false;
        if (node.val !== listNode.val) return false;
        return dfs(node.left, listNode.next) || dfs(node.right, listNode.next);
    };

    const traverse = (node) => {
        if (!node) return false;
        return dfs(node, head) || traverse(node.left) || traverse(node.right);
    };

    return traverse(root);
};
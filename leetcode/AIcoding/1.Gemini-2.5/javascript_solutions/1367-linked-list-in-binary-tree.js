var isSubPath = function(head, root) {
    if (!head) {
        return true;
    }
    if (!root) {
        return false;
    }

    return check(head, root) || isSubPath(head, root.left) || isSubPath(head, root.right);
};

function check(listNode, treeNode) {
    if (!listNode) {
        return true;
    }
    if (!treeNode) {
        return false;
    }
    if (listNode.val !== treeNode.val) {
        return false;
    }

    return check(listNode.next, treeNode.left) || check(listNode.next, treeNode.right);
}
var increasingBST = function(root) {
    let dummy = new ListNode(0);
    let current = dummy;

    function traverse(node) {
        if (!node) return;
        traverse(node.left);
        current.next = new ListNode(node.val);
        current = current.next;
        traverse(node.right);
    }

    traverse(root);
    return dummy.next;
};
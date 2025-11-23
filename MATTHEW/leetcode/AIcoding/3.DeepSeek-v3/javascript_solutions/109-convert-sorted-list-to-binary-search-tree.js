var sortedListToBST = function(head) {
    if (!head) return null;
    if (!head.next) return new TreeNode(head.val);

    let slow = head;
    let fast = head;
    let prev = null;

    while (fast && fast.next) {
        prev = slow;
        slow = slow.next;
        fast = fast.next.next;
    }

    if (prev) prev.next = null;

    const root = new TreeNode(slow.val);
    root.left = sortedListToBST(head);
    root.right = sortedListToBST(slow.next);

    return root;
};
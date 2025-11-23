var sortedListToBST = function(head) {
    if (!head) return null;

    let slow = head;
    let fast = head;
    let prev = null;

    while (fast && fast.next) {
        prev = slow;
        slow = slow.next;
        fast = fast.next.next;
    }

    const root = new TreeNode(slow.val);

    if (prev) {
        prev.next = null;
        root.left = sortedListToBST(head);
    }

    root.right = sortedListToBST(slow.next);

    return root;
};
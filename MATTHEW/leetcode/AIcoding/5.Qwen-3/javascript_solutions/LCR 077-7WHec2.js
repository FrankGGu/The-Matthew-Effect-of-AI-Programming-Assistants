var sortList = function(head) {
    if (!head || !head.next) return head;

    let slow = head, fast = head;
    while (fast.next && fast.next.next) {
        slow = slow.next;
        fast = fast.next.next;
    }

    let mid = slow.next;
    slow.next = null;

    let left = sortList(head);
    let right = sortList(mid);

    let dummy = new ListNode(0);
    let current = dummy;

    while (left && right) {
        if (left.val < right.val) {
            current.next = left;
            left = left.next;
        } else {
            current.next = right;
            right = right.next;
        }
        current = current.next;
    }

    current.next = left ? left : right;

    return dummy.next;
};
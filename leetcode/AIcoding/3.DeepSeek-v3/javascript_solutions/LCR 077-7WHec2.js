var sortList = function(head) {
    if (!head || !head.next) return head;

    let slow = head, fast = head, prev = null;
    while (fast && fast.next) {
        prev = slow;
        slow = slow.next;
        fast = fast.next.next;
    }
    prev.next = null;

    const left = sortList(head);
    const right = sortList(slow);

    return merge(left, right);
};

function merge(left, right) {
    const dummy = new ListNode(0);
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

    if (left) current.next = left;
    if (right) current.next = right;

    return dummy.next;
}
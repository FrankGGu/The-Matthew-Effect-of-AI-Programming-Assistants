var reverseBetween = function(head, left, right) {
    if (!head || left === right) {
        return head;
    }

    const dummy = new ListNode(0);
    dummy.next = head;

    let preLeft = dummy;
    for (let i = 0; i < left - 1; i++) {
        preLeft = preLeft.next;
    }

    let startReverse = preLeft.next;
    let current = startReverse.next;

    for (let i = 0; i < right - left; i++) {
        startReverse.next = current.next;
        current.next = preLeft.next;
        preLeft.next = current;
        current = startReverse.next;
    }

    return dummy.next;
};
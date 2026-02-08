var removeElements = function(head, val) {
    let dummyHead = new ListNode(0);
    dummyHead.next = head;
    let current = dummyHead;

    while (current.next !== null) {
        if (current.next.val === val) {
            current.next = current.next.next;
        } else {
            current = current.next;
        }
    }

    return dummyHead.next;
};
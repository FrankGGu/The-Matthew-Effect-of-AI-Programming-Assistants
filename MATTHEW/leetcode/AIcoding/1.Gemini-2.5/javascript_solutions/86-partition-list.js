var partition = function(head, x) {
    let lessHead = new ListNode(0);
    let lessTail = lessHead;
    let greaterHead = new ListNode(0);
    let greaterTail = greaterHead;

    let current = head;
    while (current !== null) {
        if (current.val < x) {
            lessTail.next = current;
            lessTail = lessTail.next;
        } else {
            greaterTail.next = current;
            greaterTail = greaterTail.next;
        }
        current = current.next;
    }

    greaterTail.next = null;
    lessTail.next = greaterHead.next;

    return lessHead.next;
};
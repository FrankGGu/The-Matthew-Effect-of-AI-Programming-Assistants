var partition = function(head, x) {
    let lessHead = new ListNode(0);
    let greaterHead = new ListNode(0);
    let lessTail = lessHead;
    let greaterTail = greaterHead;

    let current = head;
    while (current) {
        if (current.val < x) {
            lessTail.next = current;
            lessTail = current;
        } else {
            greaterTail.next = current;
            greaterTail = current;
        }
        current = current.next;
    }

    greaterTail.next = null;
    lessTail.next = greaterHead.next;

    return lessHead.next;
};
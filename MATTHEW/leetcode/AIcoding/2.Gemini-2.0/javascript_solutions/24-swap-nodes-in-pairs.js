var swapPairs = function(head) {
    if (!head || !head.next) {
        return head;
    }

    let dummy = new ListNode(0);
    dummy.next = head;
    let current = dummy;

    while (current.next && current.next.next) {
        let first = current.next;
        let second = current.next.next;

        first.next = second.next;
        second.next = first;
        current.next = second;

        current = first;
    }

    return dummy.next;
};
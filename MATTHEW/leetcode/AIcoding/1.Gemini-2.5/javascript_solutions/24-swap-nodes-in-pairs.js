var swapPairs = function(head) {
    let dummy = new ListNode(0);
    dummy.next = head;
    let prev = dummy;

    while (prev.next !== null && prev.next.next !== null) {
        let node1 = prev.next;
        let node2 = prev.next.next;

        prev.next = node2;
        node1.next = node2.next;
        node2.next = node1;

        prev = node1;
    }

    return dummy.next;
};
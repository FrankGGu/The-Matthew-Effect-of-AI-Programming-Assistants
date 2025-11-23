function reverseBetween(head, left, right) {
    if (!head || left === right) return head;

    let dummy = new ListNode(0, head);
    let prev = dummy;

    for (let i = 0; i < left - 1; i++) {
        prev = prev.next;
    }

    let current = prev.next;
    let tail = current;
    let next = null;

    for (let i = 0; i < right - left + 1; i++) {
        next = current.next;
        current.next = prev.next;
        prev.next = current;
        current = next;
    }

    tail.next = current;

    return dummy.next;
}
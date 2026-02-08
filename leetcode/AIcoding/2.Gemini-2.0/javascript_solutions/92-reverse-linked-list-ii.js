var reverseBetween = function(head, left, right) {
    if (!head || left === right) {
        return head;
    }

    let dummy = new ListNode(0);
    dummy.next = head;
    let pre = dummy;

    for (let i = 0; i < left - 1; i++) {
        pre = pre.next;
    }

    let curr = pre.next;
    for (let i = 0; i < right - left; i++) {
        let next = curr.next;
        curr.next = next.next;
        next.next = pre.next;
        pre.next = next;
    }

    return dummy.next;
};
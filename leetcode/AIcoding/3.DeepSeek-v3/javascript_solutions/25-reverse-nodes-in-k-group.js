var reverseKGroup = function(head, k) {
    if (!head || k === 1) return head;

    const dummy = new ListNode(0);
    dummy.next = head;
    let prev = dummy;
    let curr = head;
    let count = 0;

    while (curr) {
        count++;
        curr = curr.next;
    }

    curr = head;

    while (count >= k) {
        let tail = curr;
        let prevTail = prev;
        for (let i = 0; i < k; i++) {
            const next = curr.next;
            curr.next = prev;
            prev = curr;
            curr = next;
        }
        prevTail.next = prev;
        tail.next = curr;
        prev = tail;
        count -= k;
    }

    return dummy.next;
};
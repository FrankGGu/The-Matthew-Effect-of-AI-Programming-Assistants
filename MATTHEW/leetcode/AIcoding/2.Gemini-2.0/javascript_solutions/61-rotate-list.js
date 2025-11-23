var rotateRight = function(head, k) {
    if (!head || !head.next || k === 0) return head;

    let len = 1;
    let tail = head;
    while (tail.next) {
        tail = tail.next;
        len++;
    }

    k = k % len;
    if (k === 0) return head;

    let newTail = head;
    for (let i = 1; i < len - k; i++) {
        newTail = newTail.next;
    }

    let newHead = newTail.next;
    newTail.next = null;
    tail.next = head;

    return newHead;
};
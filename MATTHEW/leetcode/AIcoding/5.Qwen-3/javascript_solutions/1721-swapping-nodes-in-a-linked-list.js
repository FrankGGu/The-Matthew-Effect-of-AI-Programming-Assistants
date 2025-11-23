function swapNodes(head, k) {
    let first = head;
    for (let i = 0; i < k - 1; i++) {
        first = first.next;
    }

    let second = head;
    let current = first;
    while (current.next) {
        current = current.next;
        second = second.next;
    }

    let temp = first.val;
    first.val = second.val;
    second.val = temp;

    return head;
}
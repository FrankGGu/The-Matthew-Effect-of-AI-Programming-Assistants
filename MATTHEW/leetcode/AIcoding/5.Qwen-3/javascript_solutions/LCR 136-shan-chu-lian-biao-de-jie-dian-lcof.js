function deleteNode(head, val) {
    if (head === null) return null;
    if (head.val === val) return head.next;

    let current = head;
    while (current.next !== null && current.next.val !== val) {
        current = current.next;
    }

    if (current.next !== null) {
        current.next = current.next.next;
    }

    return head;
}
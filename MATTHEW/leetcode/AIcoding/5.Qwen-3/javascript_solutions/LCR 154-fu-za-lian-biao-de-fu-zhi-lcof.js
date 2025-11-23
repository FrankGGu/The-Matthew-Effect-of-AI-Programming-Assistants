function copyRandomList(head) {
    if (!head) return null;

    let current = head;
    while (current) {
        const newNode = new Node(current.val, null, null);
        newNode.next = current.next;
        current.next = newNode;
        current = newNode.next;
    }

    current = head;
    while (current) {
        if (current.random) {
            current.next.random = current.random.next;
        }
        current = current.next.next;
    }

    current = head;
    const newHead = head.next;
    while (current) {
        const next = current.next.next;
        const newCurrent = current.next;
        if (next) {
            newCurrent.next = next.next;
        }
        current = next;
    }

    return newHead;
}
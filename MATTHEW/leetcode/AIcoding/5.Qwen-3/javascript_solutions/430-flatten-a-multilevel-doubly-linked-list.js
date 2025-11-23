function flatten(head) {
    let current = head;
    while (current) {
        if (current.child) {
            let nextNode = current.next;
            let child = current.child;
            current.next = child;
            child.prev = current;
            current.child = null;
            let tail = child;
            while (tail.next) {
                tail = tail.next;
            }
            tail.next = nextNode;
            if (nextNode) {
                nextNode.prev = tail;
            }
        }
        current = current.next;
    }
    return head;
}
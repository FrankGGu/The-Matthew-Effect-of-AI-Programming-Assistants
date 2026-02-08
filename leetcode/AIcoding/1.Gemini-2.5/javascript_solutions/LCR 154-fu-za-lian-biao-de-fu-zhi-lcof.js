function copyRandomList(head: Node | null): Node | null {
    if (!head) {
        return null;
    }

    let curr: Node | null = head;
    while (curr) {
        let newNode = new Node(curr.val, curr.next, null);
        curr.next = newNode;
        curr = newNode.next;
    }

    curr = head;
    while (curr) {
        if (curr.random) {
            curr.next!.random = curr.random.next;
        }
        curr = curr.next!.next;
    }

    let originalHead: Node | null = head;
    let copiedHead: Node | null = head.next;
    let copiedCurr: Node | null = copiedHead;

    while (originalHead) {
        originalHead.next = copiedCurr!.next;
        if (copiedCurr!.next) {
            copiedCurr!.next = copiedCurr!.next.next;
        } else {
            copiedCurr!.next = null;
        }

        originalHead = originalHead.next;
        copiedCurr = copiedCurr!.next;
    }

    return copiedHead;
}
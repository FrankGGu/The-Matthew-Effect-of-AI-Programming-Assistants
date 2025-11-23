function insert(head, insertVal) {
    const newNode = new ListNode(insertVal);
    if (!head) {
        newNode.next = newNode;
        return newNode;
    }

    let curr = head;
    let toInsert = false;

    do {
        if ((curr.val <= insertVal && insertVal <= curr.next.val) ||
            (curr.val > curr.next.val && (insertVal >= curr.val || insertVal <= curr.next.val))) {
            toInsert = true;
            break;
        }
        curr = curr.next;
    } while (curr !== head);

    if (toInsert) {
        newNode.next = curr.next;
        curr.next = newNode;
    } else {
        newNode.next = head;
        curr.next = newNode;
    }

    return head;
}
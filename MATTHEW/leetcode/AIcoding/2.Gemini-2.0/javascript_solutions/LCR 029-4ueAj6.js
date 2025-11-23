var insert = function(head, insertVal) {
    const newNode = new ListNode(insertVal);

    if (!head) {
        newNode.next = newNode;
        return newNode;
    }

    let current = head;
    let next = head.next;

    while (next !== head) {
        if (current.val <= insertVal && insertVal <= next.val) {
            break;
        }
        if (current.val > next.val && (insertVal >= current.val || insertVal <= next.val)) {
            break;
        }
        current = next;
        next = next.next;
    }

    current.next = newNode;
    newNode.next = next;

    return head;
};
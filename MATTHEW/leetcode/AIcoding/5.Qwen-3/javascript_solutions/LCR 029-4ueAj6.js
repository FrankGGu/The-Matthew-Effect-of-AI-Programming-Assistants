function insert(head, insertVal) {
    if (head === null) {
        const node = new Node(insertVal);
        node.next = node;
        return node;
    }

    let current = head;
    let next = head.next;

    while (next !== head) {
        if (current.val <= insertVal && insertVal <= next.val) {
            break;
        }
        if (current.val > next.val) {
            if (insertVal >= current.val || insertVal <= next.val) {
                break;
            }
        }
        current = next;
        next = next.next;
    }

    const newNode = new Node(insertVal);
    newNode.next = next;
    current.next = newNode;

    return head;
}

function Node(val) {
    this.val = val;
    this.next = null;
}
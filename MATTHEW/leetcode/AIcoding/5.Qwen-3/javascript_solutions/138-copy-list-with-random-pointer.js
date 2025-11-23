var copyRandomList = function(head) {
    if (!head) return null;

    let node = head;
    while (node) {
        let copy = new Node(node.val, node.next, node.random);
        node.next = copy;
        node = copy.next;
    }

    node = head;
    while (node) {
        node.next.random = node.random ? node.random.next : null;
        node = node.next.next;
    }

    let newHead = head.next;
    node = head;
    while (node) {
        let copy = node.next;
        node.next = copy.next;
        node = copy.next;
    }

    return newHead;
};
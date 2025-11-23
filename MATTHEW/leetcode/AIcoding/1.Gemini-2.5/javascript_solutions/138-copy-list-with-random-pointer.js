var copyRandomList = function(head) {
    if (!head) {
        return null;
    }

    let current = head;
    while (current) {
        let newNode = new Node(current.val);
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

    let original = head;
    let copyHead = head.next;
    let copy = copyHead;

    while (original) {
        original.next = copy.next;
        copy.next = (original.next) ? original.next.next : null;

        original = original.next;
        copy = copy.next;
    }

    return copyHead;
};
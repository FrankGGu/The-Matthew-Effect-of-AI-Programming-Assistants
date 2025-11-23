var flatten = function(head) {
    if (!head) {
        return head;
    }

    let curr = head;

    while (curr) {
        if (curr.child) {
            let nextNode = curr.next;

            curr.next = curr.child;
            curr.child.prev = curr;

            let childTail = curr.child;
            while (childTail.next) {
                childTail = childTail.next;
            }

            childTail.next = nextNode;
            if (nextNode) {
                nextNode.prev = childTail;
            }

            curr.child = null;
        }
        curr = curr.next;
    }

    return head;
};
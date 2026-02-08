var flatten = function(head) {
    if (!head) return head;

    let curr = head;
    while (curr) {
        if (curr.child) {
            let nextNode = curr.next;
            let childHead = curr.child;

            curr.next = childHead;
            childHead.prev = curr;
            curr.child = null;

            let childTail = childHead;
            while (childTail.next) {
                childTail = childTail.next;
            }

            if (nextNode) {
                childTail.next = nextNode;
                nextNode.prev = childTail;
            }

            curr = childHead;
        } else {
            curr = curr.next;
        }
    }

    return head;
};
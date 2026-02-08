var flatten = function(head) {
    let curr = head;
    while (curr) {
        if (curr.child) {
            let nextNode = curr.next;
            let childNode = curr.child;
            curr.next = childNode;
            childNode.prev = curr;
            curr.child = null;

            let tail = childNode;
            while (tail.next) {
                tail = tail.next;
            }

            if (nextNode) {
                tail.next = nextNode;
                nextNode.prev = tail;
            }
            curr = childNode;
        } else {
            curr = curr.next;
        }
    }
    return head;
};
var flatten = function(head) {
    if (!head) return null;
    let current = head;
    while (current) {
        if (current.child) {
            let next = current.next;
            let child = flatten(current.child);
            current.child = null;
            current.next = child;
            child.prev = current;
            while (current.next) {
                current = current.next;
            }
            if (next) {
                current.next = next;
                next.prev = current;
            }
        }
        current = current.next;
    }
    return head;
};
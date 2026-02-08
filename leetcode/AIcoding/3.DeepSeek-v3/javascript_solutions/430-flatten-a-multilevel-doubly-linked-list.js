var flatten = function(head) {
    if (!head) return head;
    let current = head;
    while (current) {
        if (current.child) {
            let next = current.next;
            let child = flatten(current.child);
            current.child = null;
            current.next = child;
            child.prev = current;
            while (child.next) {
                child = child.next;
            }
            child.next = next;
            if (next) next.prev = child;
            current = next;
        } else {
            current = current.next;
        }
    }
    return head;
};
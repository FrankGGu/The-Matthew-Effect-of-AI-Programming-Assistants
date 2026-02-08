class Node {
    constructor(val, prev, next, child) {
        this.val = val;
        this.prev = prev;
        this.next = next;
        this.child = child;
    }
}

var flatten = function(head) {
    if (!head) return null;

    const stack = [];
    let current = head;
    let prev = null;

    while (current || stack.length) {
        if (current) {
            if (prev) {
                prev.next = current;
                current.prev = prev;
            }
            stack.push(current.next);
            prev = current;
            if (current.child) {
                current.next = current.child;
                current.child.prev = current;
                current.child = null;
            }
            current = current.next;
        } else {
            current = stack.pop();
        }
    }

    return head;
};
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
    const dummy = new Node(0, null, null, null);
    let prev = dummy;

    while (current || stack.length) {
        if (current) {
            prev.next = current;
            current.prev = prev;
            prev = current;

            if (current.child) {
                if (current.next) stack.push(current.next);
                current = current.child;
                current.child = null; // clear the child pointer
            } else {
                current = current.next;
            }
        } else {
            current = stack.pop();
        }
    }

    dummy.next.prev = null; // detach the dummy node
    return dummy.next;
};
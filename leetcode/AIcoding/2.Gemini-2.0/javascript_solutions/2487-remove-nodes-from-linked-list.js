var removeNodes = function(head) {
    let stack = [];
    let curr = head;

    while (curr) {
        while (stack.length > 0 && stack[stack.length - 1].val < curr.val) {
            stack.pop();
        }
        stack.push(curr);
        curr = curr.next;
    }

    if (stack.length === 0) return null;

    let newHead = stack[0];
    let prev = newHead;

    for (let i = 1; i < stack.length; i++) {
        prev.next = stack[i];
        prev = stack[i];
    }

    prev.next = null;
    return newHead;
};
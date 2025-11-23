var doubleIt = function(head) {
    let stack = [];
    let current = head;
    while (current) {
        stack.push(current.val);
        current = current.next;
    }

    let carry = 0;
    let newHead = null;
    while (stack.length > 0 || carry > 0) {
        let val = stack.length > 0 ? stack.pop() : 0;
        let doubled = val * 2 + carry;
        carry = Math.floor(doubled / 10);
        let newNode = new ListNode(doubled % 10);
        newNode.next = newHead;
        newHead = newNode;
    }

    return newHead;
};
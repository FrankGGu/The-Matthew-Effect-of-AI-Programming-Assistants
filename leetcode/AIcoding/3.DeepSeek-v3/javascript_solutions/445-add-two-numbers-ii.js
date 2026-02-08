var addTwoNumbers = function(l1, l2) {
    const stack1 = [];
    const stack2 = [];

    while (l1 !== null) {
        stack1.push(l1.val);
        l1 = l1.next;
    }

    while (l2 !== null) {
        stack2.push(l2.val);
        l2 = l2.next;
    }

    let carry = 0;
    let head = null;

    while (stack1.length > 0 || stack2.length > 0 || carry > 0) {
        const val1 = stack1.length > 0 ? stack1.pop() : 0;
        const val2 = stack2.length > 0 ? stack2.pop() : 0;
        const sum = val1 + val2 + carry;
        carry = Math.floor(sum / 10);
        const newNode = new ListNode(sum % 10);
        newNode.next = head;
        head = newNode;
    }

    return head;
};
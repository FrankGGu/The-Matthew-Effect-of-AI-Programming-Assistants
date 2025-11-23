var addTwoNumbers = function(l1, l2) {
    let stack1 = [];
    let stack2 = [];

    while (l1) {
        stack1.push(l1.val);
        l1 = l1.next;
    }

    while (l2) {
        stack2.push(l2.val);
        l2 = l2.next;
    }

    let carry = 0;
    let result = null;

    while (stack1.length > 0 || stack2.length > 0 || carry > 0) {
        let val1 = stack1.length > 0 ? stack1.pop() : 0;
        let val2 = stack2.length > 0 ? stack2.pop() : 0;

        let sum = val1 + val2 + carry;
        carry = Math.floor(sum / 10);
        let digit = sum % 10;

        let newNode = new ListNode(digit);
        newNode.next = result;
        result = newNode;
    }

    return result;
};
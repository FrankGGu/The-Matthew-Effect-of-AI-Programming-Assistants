var addTwoNumbers = function(l1, l2) {
    const s1 = [];
    const s2 = [];

    let current = l1;
    while (current) {
        s1.push(current.val);
        current = current.next;
    }

    current = l2;
    while (current) {
        s2.push(current.val);
        current = current.next;
    }

    let head = null;
    let carry = 0;

    while (s1.length > 0 || s2.length > 0 || carry > 0) {
        const val1 = s1.length > 0 ? s1.pop() : 0;
        const val2 = s2.length > 0 ? s2.pop() : 0;

        const sum = val1 + val2 + carry;
        carry = Math.floor(sum / 10);
        const digit = sum % 10;

        const newNode = new ListNode(digit);
        newNode.next = head;
        head = newNode;
    }

    return head;
};
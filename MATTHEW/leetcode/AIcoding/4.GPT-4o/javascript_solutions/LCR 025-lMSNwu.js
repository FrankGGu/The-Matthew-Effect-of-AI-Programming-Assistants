var addTwoNumbers = function(l1, l2) {
    let dummyHead = new ListNode(0);
    let p = l1, q = l2, current = dummyHead;
    let carry = 0;

    while (p || q || carry) {
        let x = p ? p.val : 0;
        let y = q ? q.val : 0;
        let sum = carry + x + y;
        carry = Math.floor(sum / 10);
        current.next = new ListNode(sum % 10);
        current = current.next;
        if (p) p = p.next;
        if (q) q = q.next;
    }

    return dummyHead.next;
};
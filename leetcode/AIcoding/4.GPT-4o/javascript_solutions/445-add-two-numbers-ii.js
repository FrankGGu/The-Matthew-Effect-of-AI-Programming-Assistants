class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var addTwoNumbers = function(l1, l2) {
    const reverseList = (head) => {
        let prev = null;
        while (head) {
            const next = head.next;
            head.next = prev;
            prev = head;
            head = next;
        }
        return prev;
    };

    l1 = reverseList(l1);
    l2 = reverseList(l2);

    let dummy = new ListNode(0);
    let p = l1, q = l2, carry = 0;

    while (p || q || carry) {
        const x = p ? p.val : 0;
        const y = q ? q.val : 0;
        const sum = x + y + carry;
        carry = Math.floor(sum / 10);
        dummy.next = new ListNode(sum % 10);
        dummy = dummy.next;
        if (p) p = p.next;
        if (q) q = q.next;
    }

    return reverseList(dummy.next);
};
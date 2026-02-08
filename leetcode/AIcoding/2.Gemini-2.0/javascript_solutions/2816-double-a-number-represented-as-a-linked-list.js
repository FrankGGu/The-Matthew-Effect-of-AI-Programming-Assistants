var doubleIt = function(head) {
    let carry = 0;

    function doubleList(node) {
        if (!node) {
            return 0;
        }

        let nextCarry = doubleList(node.next);
        let doubledVal = node.val * 2 + nextCarry;
        node.val = doubledVal % 10;
        return Math.floor(doubledVal / 10);
    }

    carry = doubleList(head);

    if (carry > 0) {
        let newHead = new ListNode(carry);
        newHead.next = head;
        return newHead;
    } else {
        return head;
    }
};
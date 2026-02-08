var doubleIt = function(head) {
    function recurseAndDouble(node) {
        if (!node) {
            return 0;
        }

        let carryFromNext = recurseAndDouble(node.next);
        let doubledValue = node.val * 2 + carryFromNext;
        node.val = doubledValue % 10;
        return Math.floor(doubledValue / 10);
    }

    let finalCarry = recurseAndDouble(head);

    if (finalCarry > 0) {
        let newHead = new ListNode(finalCarry);
        newHead.next = head;
        return newHead;
    } else {
        return head;
    }
};
var doubleIt = function(head) {
    function doubleAndCarry(node) {
        if (node === null) {
            return 0;
        }

        let carryFromNext = doubleAndCarry(node.next);

        let newVal = node.val * 2 + carryFromNext;
        node.val = newVal % 10;

        return Math.floor(newVal / 10);
    }

    let finalCarry = doubleAndCarry(head);

    if (finalCarry > 0) {
        let newHead = new ListNode(finalCarry);
        newHead.next = head;
        return newHead;
    } else {
        return head;
    }
};
var insertionSortList = function(head) {
    if (!head || !head.next) {
        return head;
    }

    let dummy = new ListNode(0);
    let curr = head;

    while (curr !== null) {
        let nextNode = curr.next;

        let prevSorted = dummy;
        while (prevSorted.next !== null && prevSorted.next.val < curr.val) {
            prevSorted = prevSorted.next;
        }

        curr.next = prevSorted.next;
        prevSorted.next = curr;

        curr = nextNode;
    }

    return dummy.next;
};
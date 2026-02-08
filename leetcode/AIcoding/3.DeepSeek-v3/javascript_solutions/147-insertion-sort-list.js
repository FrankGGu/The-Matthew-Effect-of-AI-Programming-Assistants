var insertionSortList = function(head) {
    if (!head || !head.next) return head;

    let dummy = new ListNode(0);
    dummy.next = head;
    let lastSorted = head;
    let curr = head.next;

    while (curr) {
        if (lastSorted.val <= curr.val) {
            lastSorted = lastSorted.next;
        } else {
            let prev = dummy;
            while (prev.next.val <= curr.val) {
                prev = prev.next;
            }
            lastSorted.next = curr.next;
            curr.next = prev.next;
            prev.next = curr;
        }
        curr = lastSorted.next;
    }

    return dummy.next;
};
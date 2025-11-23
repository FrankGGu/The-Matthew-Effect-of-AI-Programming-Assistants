var insertionSortList = function(head) {
    if (!head || !head.next) return head;

    const dummy = new ListNode(0);
    let current = head;

    while (current) {
        let temp = dummy;
        while (temp.next && temp.next.val < current.val) {
            temp = temp.next;
        }
        const nextNode = current.next;
        current.next = temp.next;
        temp.next = current;
        current = nextNode;
    }

    return dummy.next;
};
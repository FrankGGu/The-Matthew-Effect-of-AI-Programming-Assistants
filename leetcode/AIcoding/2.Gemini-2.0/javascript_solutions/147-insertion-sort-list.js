var insertionSortList = function(head) {
    if (!head || !head.next) return head;

    let dummy = new ListNode(0);
    dummy.next = head;
    let current = head.next;
    let prev = head;

    while (current) {
        if (current.val >= prev.val) {
            prev = current;
            current = current.next;
        } else {
            let temp = dummy;
            while (temp.next.val < current.val) {
                temp = temp.next;
            }

            prev.next = current.next;
            current.next = temp.next;
            temp.next = current;

            current = prev.next;
        }
    }

    return dummy.next;
};
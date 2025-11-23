var deleteDuplicates = function(head) {
    let dummy = new ListNode(0);
    dummy.next = head;
    let prev = dummy;

    while (head) {
        if (head.next && head.val === head.next.val) {
            while (head.next && head.val === head.next.val) {
                head = head.next;
            }
            prev.next = head.next;
        } else {
            prev = prev.next;
        }
        head = head.next;
    }

    return dummy.next;
};
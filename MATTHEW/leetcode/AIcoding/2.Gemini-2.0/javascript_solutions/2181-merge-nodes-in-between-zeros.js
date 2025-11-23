var mergeNodes = function(head) {
    let dummy = new ListNode(0);
    let tail = dummy;
    let sum = 0;
    let curr = head.next;

    while (curr) {
        if (curr.val === 0) {
            tail.next = new ListNode(sum);
            tail = tail.next;
            sum = 0;
        } else {
            sum += curr.val;
        }
        curr = curr.next;
    }

    return dummy.next;
};
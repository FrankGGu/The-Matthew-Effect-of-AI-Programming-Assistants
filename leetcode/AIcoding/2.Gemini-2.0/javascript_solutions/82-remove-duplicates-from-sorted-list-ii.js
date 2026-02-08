var deleteDuplicates = function(head) {
    let dummy = { next: head };
    let prev = dummy;
    let curr = head;

    while (curr) {
        if (curr.next && curr.val === curr.next.val) {
            while (curr.next && curr.val === curr.next.val) {
                curr = curr.next;
            }
            prev.next = curr.next;
        } else {
            prev = curr;
        }
        curr = curr.next;
    }

    return dummy.next;
};
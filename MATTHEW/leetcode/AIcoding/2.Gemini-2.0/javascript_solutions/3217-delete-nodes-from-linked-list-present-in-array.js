var deleteNodes = function(head, nums) {
    let dummy = new ListNode(0);
    dummy.next = head;
    let curr = dummy;
    let set = new Set(nums);

    while (curr && curr.next) {
        if (set.has(curr.next.val)) {
            curr.next = curr.next.next;
        } else {
            curr = curr.next;
        }
    }

    return dummy.next;
};
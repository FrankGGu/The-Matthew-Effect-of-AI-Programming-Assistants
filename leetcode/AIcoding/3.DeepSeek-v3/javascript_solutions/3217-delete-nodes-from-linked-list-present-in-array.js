var deleteNodes = function(head, nums) {
    const set = new Set(nums);
    let dummy = new ListNode(0);
    dummy.next = head;
    let prev = dummy;
    let current = head;

    while (current) {
        if (set.has(current.val)) {
            prev.next = current.next;
        } else {
            prev = current;
        }
        current = current.next;
    }

    return dummy.next;
};
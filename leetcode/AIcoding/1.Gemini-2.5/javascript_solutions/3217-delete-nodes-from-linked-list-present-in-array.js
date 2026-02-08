var deleteNodes = function(head, nums) {
    const valuesToDelete = new Set(nums);

    let dummyHead = new ListNode(0);
    dummyHead.next = head;

    let current = head;
    let previous = dummyHead;

    while (current !== null) {
        if (valuesToDelete.has(current.val)) {
            previous.next = current.next;
        } else {
            previous = current;
        }
        current = current.next;
    }

    return dummyHead.next;
};
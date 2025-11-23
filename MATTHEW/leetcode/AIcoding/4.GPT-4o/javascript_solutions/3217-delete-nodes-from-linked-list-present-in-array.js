class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var deleteNodes = function(head, toDelete) {
    const toDeleteSet = new Set(toDelete);
    let dummy = new ListNode(0);
    let current = dummy;

    while (head) {
        if (!toDeleteSet.has(head.val)) {
            current.next = head;
            current = current.next;
        }
        head = head.next;
    }

    current.next = null;
    return dummy.next;
};
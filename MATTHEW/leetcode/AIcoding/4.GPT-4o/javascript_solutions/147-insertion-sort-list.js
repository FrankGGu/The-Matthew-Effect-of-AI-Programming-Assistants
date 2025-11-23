class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var insertionSortList = function(head) {
    if (!head) return null;

    let sorted = new ListNode(0);

    let current = head;

    while (current) {
        let prev = sorted;
        let next = sorted.next;

        while (next && next.val < current.val) {
            prev = next;
            next = next.next;
        }

        let newNode = new ListNode(current.val);
        prev.next = newNode;
        newNode.next = next;

        current = current.next;
    }

    return sorted.next;
};
class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var mergeNodes = function(head) {
    let dummy = new ListNode(0);
    let current = dummy;
    let sum = 0;
    let node = head.next; // Start from the first node after the first zero

    while (node) {
        if (node.val === 0) {
            if (sum > 0) {
                current.next = new ListNode(sum);
                current = current.next;
                sum = 0;
            }
        } else {
            sum += node.val;
        }
        node = node.next;
    }

    return dummy.next;
};
class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var removeNthFromEnd = function(head, n) {
    let dummy = new ListNode(0, head);
    let first = dummy;
    let second = dummy;

    for (let i = 0; i <= n; i++) {
        first = first.next;
    }

    while (first !== null) {
        first = first.next;
        second = second.next;
    }

    second.next = second.next.next;
    return dummy.next;
};
class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var rotateRight = function(head, k) {
    if (!head || !head.next || k === 0) return head;

    let length = 1;
    let tail = head;

    while (tail.next) {
        tail = tail.next;
        length++;
    }

    tail.next = head;
    k = k % length;
    let stepsToNewHead = length - k;

    let newTail = tail;
    while (stepsToNewHead > 0) {
        newTail = newTail.next;
        stepsToNewHead--;
    }

    newHead = newTail.next;
    newTail.next = null;

    return newHead;
};
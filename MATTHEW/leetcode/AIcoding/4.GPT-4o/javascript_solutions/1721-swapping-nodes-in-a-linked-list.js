class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var swapNodes = function(head, k) {
    let slow = head, fast = head;
    let first = null, second = null;
    let count = 1;

    while (fast && fast.next) {
        fast = fast.next.next;
        if (count === k) {
            first = slow;
        }
        slow = slow.next;
        count++;
    }

    count -= k;
    slow = head;
    while (count > 0) {
        slow = slow.next;
        count--;
    }
    second = slow;

    let temp = first.val;
    first.val = second.val;
    second.val = temp;

    return head;
};
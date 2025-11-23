class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var pairSum = function(head) {
    let slow = head, fast = head;
    const stack = [];

    while (fast && fast.next) {
        stack.push(slow.val);
        slow = slow.next;
        fast = fast.next.next;
    }

    let maxSum = 0;

    while (slow) {
        maxSum = Math.max(maxSum, slow.val + stack.pop());
        slow = slow.next;
    }

    return maxSum;
};
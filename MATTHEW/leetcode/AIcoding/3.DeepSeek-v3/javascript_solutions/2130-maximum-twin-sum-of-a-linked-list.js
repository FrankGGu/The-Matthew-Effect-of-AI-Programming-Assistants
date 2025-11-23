var pairSum = function(head) {
    let slow = head;
    let fast = head;
    while (fast && fast.next) {
        slow = slow.next;
        fast = fast.next.next;
    }

    let prev = null;
    let nextNode = null;
    while (slow) {
        nextNode = slow.next;
        slow.next = prev;
        prev = slow;
        slow = nextNode;
    }

    let maxSum = 0;
    let first = head;
    let second = prev;
    while (second) {
        maxSum = Math.max(maxSum, first.val + second.val);
        first = first.next;
        second = second.next;
    }

    return maxSum;
};
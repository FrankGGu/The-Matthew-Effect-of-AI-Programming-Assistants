var pairSum = function(head) {
    let slow = head;
    let fast = head;
    while (fast && fast.next) {
        slow = slow.next;
        fast = fast.next.next;
    }

    let prev = null;
    let current = slow;
    while (current) {
        let nextTemp = current.next;
        current.next = prev;
        prev = current;
        current = nextTemp;
    }

    let maxSum = 0;
    let p1 = head;
    let p2 = prev;

    while (p2) {
        maxSum = Math.max(maxSum, p1.val + p2.val);
        p1 = p1.next;
        p2 = p2.next;
    }

    return maxSum;
};
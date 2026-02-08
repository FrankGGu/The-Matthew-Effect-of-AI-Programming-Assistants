var swapNodes = function(head, k) {
    let first = head;
    for (let i = 1; i < k; i++) {
        first = first.next;
    }

    let slow = head;
    let fast = first.next;
    while (fast) {
        slow = slow.next;
        fast = fast.next;
    }

    const temp = first.val;
    first.val = slow.val;
    slow.val = temp;

    return head;
};
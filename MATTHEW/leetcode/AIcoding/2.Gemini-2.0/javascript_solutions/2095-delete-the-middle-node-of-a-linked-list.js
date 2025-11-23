var deleteMiddle = function(head) {
    if (!head || !head.next) return null;

    let slow = head;
    let fast = head;
    let prev = null;

    while (fast && fast.next) {
        prev = slow;
        slow = slow.next;
        fast = fast.next.next;
    }

    prev.next = slow.next;

    return head;
};
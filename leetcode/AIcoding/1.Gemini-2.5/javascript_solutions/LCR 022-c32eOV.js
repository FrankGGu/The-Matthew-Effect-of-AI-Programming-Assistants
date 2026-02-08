var detectCycle = function(head) {
    if (!head || !head.next) {
        return null;
    }

    let slow = head;
    let fast = head;

    while (fast && fast.next) {
        slow = slow.next;
        fast = fast.next.next;

        if (slow === fast) {
            // Cycle detected
            slow = head;
            while (slow !== fast) {
                slow = slow.next;
                fast = fast.next;
            }
            return slow; // This is the start of the cycle
        }
    }

    return null; // No cycle
};
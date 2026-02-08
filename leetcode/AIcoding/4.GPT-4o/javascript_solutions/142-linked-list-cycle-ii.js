function detectCycle(head) {
    if (!head || !head.next) return null;

    let slow = head;
    let fast = head;

    while (fast && fast.next) {
        slow = slow.next;
        fast = fast.next.next;

        if (slow === fast) {
            let entry = head;
            while (entry !== slow) {
                entry = entry.next;
                slow = slow.next;
            }
            return entry;
        }
    }

    return null;
}
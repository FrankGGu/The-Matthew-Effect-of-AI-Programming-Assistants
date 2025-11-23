var reorderList = function(head) {
    if (!head || !head.next || !head.next.next) {
        return;
    }

    // 1. Find the middle of the list
    let slow = head;
    let fast = head;
    let prev = null; // To keep track of the node before slow for splitting

    while (fast && fast.next) {
        prev = slow;
        slow = slow.next;
        fast = fast.next.next;
    }

    // Now 'slow' is the head of the second half.
    // 'prev' is the tail of the first half.

    // 2. Split the list into two halves
    // The first half ends at 'prev', the second half starts at 'slow'.
    if (prev) {
        prev.next = null;
    }

    let head1 = head; // First half
    let head2 = slow; // Second half

    // 3. Reverse the second half
    let prev2 = null;
    let curr2 = head2;
    while (curr2) {
        let nextTemp = curr2.next;
        curr2.next = prev2;
        prev2 = curr2;
        curr2 = nextTemp;
    }
    head2 = prev2; // head2 is now the head of the reversed second half

    // 4. Merge the two halves alternately
    let p1 = head1;
    let p2 = head2;

    while (p1 && p2) {
        let next1 = p1.next;
        let next2 = p2.next;

        p1.next = p2;
        p2.next = next1;

        p1 = next1;
        p2 = next2;
    }
};
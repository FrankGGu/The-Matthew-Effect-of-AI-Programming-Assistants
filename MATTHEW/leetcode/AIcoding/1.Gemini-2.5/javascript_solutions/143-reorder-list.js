var reorderList = function(head) {
    if (!head || !head.next || !head.next.next) {
        return;
    }

    // Step 1: Find the middle of the linked list
    let slow = head;
    let fast = head;
    while (fast.next && fast.next.next) {
        slow = slow.next;
        fast = fast.next.next;
    }

    // `slow` is now at the end of the first half
    // `mid` will be the head of the second half
    let mid = slow.next;
    slow.next = null; // Split the list into two halves

    // Step 2: Reverse the second half
    let prev = null;
    let curr = mid;
    while (curr) {
        let nextTemp = curr.next;
        curr.next = prev;
        prev = curr;
        curr = nextTemp;
    }
    let secondHalfHead = prev; // `prev` is now the head of the reversed second half

    // Step 3: Merge the two halves alternately
    let p1 = head;
    let p2 = secondHalfHead;
    while (p2) {
        let temp1 = p1.next;
        let temp2 = p2.next;

        p1.next = p2;
        p2.next = temp1;

        p1 = temp1;
        p2 = temp2;
    }
};
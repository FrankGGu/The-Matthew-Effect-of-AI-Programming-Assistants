var insert = function(head, insertVal) {
    if (!head) {
        const newNode = new Node(insertVal);
        newNode.next = newNode;
        return newNode;
    }

    let prev = head;
    let curr = head.next;
    let inserted = false;

    do {
        if ((prev.val <= insertVal && insertVal <= curr.val) || // Case 1: Insert in the middle
            (prev.val > curr.val && (insertVal >= prev.val || insertVal <= curr.val))) { // Case 2: Insert at wrap-around point

            prev.next = new Node(insertVal, curr);
            inserted = true;
            break;
        }

        prev = curr;
        curr = curr.next;

    } while (prev !== head); // Loop until we've made a full circle

    // Case 3: If no insertion happened (all elements are the same, or no suitable spot found in the loop)
    // This implies all elements in the list are identical. Insert anywhere, e.g., after prev.
    if (!inserted) {
        prev.next = new Node(insertVal, curr);
    }

    return head;
};
var swapNodes = function(head, k) {
    let first = null;
    let second = null;
    let current = head;
    let count = 1;

    while (current) {
        if (count === k) {
            first = current;
            second = head;
        }

        if (count > k) {
            second = second.next;
        }

        current = current.next;
        count++;
    }

    let temp = first.val;
    first.val = second.val;
    second.val = temp;

    return head;
};
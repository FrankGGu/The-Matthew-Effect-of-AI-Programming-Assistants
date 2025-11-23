var swapNodes = function(head, k) {
    let firstNode = null;
    let secondNode = head;
    let current = head;

    for (let i = 1; i < k; i++) {
        current = current.next;
    }

    firstNode = current;

    while (current.next !== null) {
        current = current.next;
        secondNode = secondNode.next;
    }

    let temp = firstNode.val;
    firstNode.val = secondNode.val;
    secondNode.val = temp;

    return head;
};
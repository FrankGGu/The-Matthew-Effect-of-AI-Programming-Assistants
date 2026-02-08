var reverseList = function(head) {
    let prev = null;
    let current = head;
    while (current !== null) {
        let nextTemp = current.next;
        current.next = prev;
        prev = current;
        current = nextTemp;
    }
    return prev;
};
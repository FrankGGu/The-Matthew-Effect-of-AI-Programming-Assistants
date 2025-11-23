var getDecimalValue = function(head) {
    let num = 0;
    let current = head;
    while (current !== null) {
        num = num * 2 + current.val;
        current = current.next;
    }
    return num;
};
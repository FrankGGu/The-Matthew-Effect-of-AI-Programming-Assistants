var getDecimalValue = function(head) {
    let result = 0;
    let current = head;

    while (current !== null) {
        result = (result << 1) | current.val;
        current = current.next;
    }

    return result;
};
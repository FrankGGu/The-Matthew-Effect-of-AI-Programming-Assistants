var reverseBookList = function(head) {
    let prev = null;
    let current = head;
    while (current !== null) {
        let nextTemp = current.next;
        current.next = prev;
        prev = current;
        current = nextTemp;
    }
    let result = [];
    while (prev !== null) {
        result.push(prev.val);
        prev = prev.next;
    }
    return result;
};
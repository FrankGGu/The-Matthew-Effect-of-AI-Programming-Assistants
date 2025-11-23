var nextLargerNodes = function(head) {
    let stack = [];
    let res = [];
    let idx = 0;
    let current = head;
    let values = [];

    while (current) {
        values.push(current.val);
        current = current.next;
    }

    res = new Array(values.length).fill(0);

    for (let i = 0; i < values.length; i++) {
        while (stack.length > 0 && values[stack[stack.length - 1]] < values[i]) {
            res[stack.pop()] = values[i];
        }
        stack.push(i);
    }

    return res;
};
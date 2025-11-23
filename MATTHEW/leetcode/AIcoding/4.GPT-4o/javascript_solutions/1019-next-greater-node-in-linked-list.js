class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var nextLargerNodes = function(head) {
    const result = [];
    const stack = [];
    let index = 0;
    let current = head;

    while (current) {
        result.push(0);
        while (stack.length && current.val > stack[stack.length - 1][0]) {
            const [val, idx] = stack.pop();
            result[idx] = current.val;
        }
        stack.push([current.val, index]);
        current = current.next;
        index++;
    }

    return result;
};
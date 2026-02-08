function ListNode(val, next) {
    this.val = (val === undefined ? 0 : val)
    this.next = (next === undefined ? null : next)
}

var nextLargerNode = function(head) {
    let stack = [];
    let result = [];
    let index = 0;

    while (head) {
        result.push(0);
        while (stack.length > 0 && head.val > stack[stack.length - 1].val) {
            let prevNode = stack.pop();
            result[prevNode.index] = head.val;
        }
        stack.push({ val: head.val, index: index });
        index++;
        head = head.next;
    }

    return result;
};
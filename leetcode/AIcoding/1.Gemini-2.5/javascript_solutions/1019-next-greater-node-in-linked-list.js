var nextLargerNodes = function(head) {
    let values = [];
    let current = head;
    while (current) {
        values.push(current.val);
        current = current.next;
    }

    let ans = new Array(values.length).fill(0);
    let stack = [];

    for (let i = 0; i < values.length; i++) {
        while (stack.length > 0 && values[stack[stack.length - 1]] < values[i]) {
            let prevIndex = stack.pop();
            ans[prevIndex] = values[i];
        }
        stack.push(i);
    }

    return ans;
};
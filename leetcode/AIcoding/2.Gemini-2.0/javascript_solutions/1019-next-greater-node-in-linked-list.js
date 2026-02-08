var nextLargerNodes = function(head) {
    let arr = [];
    let current = head;
    while (current) {
        arr.push(current.val);
        current = current.next;
    }

    let n = arr.length;
    let result = new Array(n).fill(0);
    let stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && arr[i] > arr[stack[stack.length - 1]]) {
            result[stack.pop()] = arr[i];
        }
        stack.push(i);
    }

    return result;
};
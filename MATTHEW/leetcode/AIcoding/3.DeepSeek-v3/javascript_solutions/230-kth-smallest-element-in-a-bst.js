var kthSmallest = function(root, k) {
    let stack = [];
    let current = root;
    let count = 0;

    while (current !== null || stack.length > 0) {
        while (current !== null) {
            stack.push(current);
            current = current.left;
        }
        current = stack.pop();
        count++;
        if (count === k) {
            return current.val;
        }
        current = current.right;
    }
    return -1;
};
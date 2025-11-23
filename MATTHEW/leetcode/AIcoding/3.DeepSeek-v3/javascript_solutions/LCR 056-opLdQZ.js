var findTarget = function(root, k) {
    const set = new Set();
    const stack = [];
    let curr = root;

    while (curr !== null || stack.length > 0) {
        while (curr !== null) {
            stack.push(curr);
            curr = curr.left;
        }
        curr = stack.pop();
        if (set.has(k - curr.val)) {
            return true;
        }
        set.add(curr.val);
        curr = curr.right;
    }
    return false;
};
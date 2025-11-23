var findTarget = function(root, k) {
    const set = new Set();
    const stack = [];
    let current = root;

    while (current !== null || stack.length > 0) {
        while (current !== null) {
            stack.push(current);
            current = current.left;
        }
        current = stack.pop();
        if (set.has(k - current.val)) {
            return true;
        }
        set.add(current.val);
        current = current.right;
    }
    return false;
};
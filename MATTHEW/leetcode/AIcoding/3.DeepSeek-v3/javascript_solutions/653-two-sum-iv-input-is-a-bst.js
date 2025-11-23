var findTarget = function(root, k) {
    const set = new Set();
    const stack = [root];

    while (stack.length > 0) {
        const node = stack.pop();
        if (set.has(k - node.val)) {
            return true;
        }
        set.add(node.val);
        if (node.right) stack.push(node.right);
        if (node.left) stack.push(node.left);
    }
    return false;
};
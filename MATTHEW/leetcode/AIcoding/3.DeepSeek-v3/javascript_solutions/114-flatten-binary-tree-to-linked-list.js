var flatten = function(root) {
    if (!root) return;

    let stack = [root];
    let prev = null;

    while (stack.length) {
        let node = stack.pop();

        if (prev) {
            prev.left = null;
            prev.right = node;
        }

        if (node.right) stack.push(node.right);
        if (node.left) stack.push(node.left);

        prev = node;
    }
};
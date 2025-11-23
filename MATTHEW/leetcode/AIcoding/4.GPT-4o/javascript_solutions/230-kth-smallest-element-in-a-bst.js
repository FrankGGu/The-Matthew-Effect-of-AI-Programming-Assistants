var kthSmallest = function(root, k) {
    const stack = [];
    let count = 0;

    while (true) {
        while (root) {
            stack.push(root);
            root = root.left;
        }
        root = stack.pop();
        count++;
        if (count === k) return root.val;
        root = root.right;
    }
};
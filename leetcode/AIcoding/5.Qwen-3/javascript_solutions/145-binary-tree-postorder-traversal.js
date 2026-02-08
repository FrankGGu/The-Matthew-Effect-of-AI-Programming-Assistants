function postorderTraversal(root) {
    const result = [];
    const stack = [];
    let prev = null;

    while (root || stack.length > 0) {
        while (root) {
            stack.push(root);
            root = root.left;
        }
        root = stack[stack.length - 1];
        if (root.right === null || root.right === prev) {
            result.push(root.val);
            prev = root;
            stack.pop();
            root = null;
        } else {
            root = root.right;
        }
    }
    return result;
}
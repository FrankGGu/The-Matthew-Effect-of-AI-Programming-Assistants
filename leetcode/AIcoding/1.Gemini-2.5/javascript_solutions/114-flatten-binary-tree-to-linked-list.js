var flatten = function(root) {
    if (!root) {
        return;
    }

    let current = root;
    while (current) {
        if (current.left) {
            let pre = current.left;
            while (pre.right) {
                pre = pre.right;
            }

            pre.right = current.right;
            current.right = current.left;
            current.left = null;
        }
        current = current.right;
    }
};
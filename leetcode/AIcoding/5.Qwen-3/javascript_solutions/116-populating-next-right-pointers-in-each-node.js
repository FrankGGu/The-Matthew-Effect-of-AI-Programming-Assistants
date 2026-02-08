var connect = function(root) {
    if (!root) return root;

    let levelStart = root;

    while (levelStart) {
        let current = levelStart;
        while (current) {
            if (current.left) {
                current.left.next = current.right;
            }
            if (current.right) {
                current.right.next = current.next ? current.next.left : null;
            }
            current = current.next;
        }
        levelStart = levelStart.left;
    }

    return root;
};
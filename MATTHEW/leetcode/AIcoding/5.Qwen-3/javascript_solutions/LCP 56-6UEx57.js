function connect(root) {
    if (!root) return null;

    let levelStart = root;

    while (levelStart) {
        let current = levelStart;
        let prev = null;

        while (current) {
            if (prev) {
                prev.next = current.left || current.right;
            }

            if (current.left) {
                current.left.next = current.right;
            }

            prev = current.right ? current.right : current.left;

            current = current.next;
        }

        while (levelStart && !levelStart.left && !levelStart.right) {
            levelStart = levelStart.next;
        }

        if (levelStart) {
            levelStart = levelStart.left ? levelStart.left : levelStart.right;
        }
    }

    return root;
}
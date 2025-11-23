var connect = function(root) {
    if (!root) {
        return root;
    }

    let leftmost = root;

    while (leftmost.left !== null) {
        let current = leftmost;
        while (current !== null) {
            current.left.next = current.right;
            if (current.next !== null) {
                current.right.next = current.next.left;
            }
            current = current.next;
        }
        leftmost = leftmost.left;
    }

    return root;
};
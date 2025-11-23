function isEvenOddTree(root) {
    if (!root) return true;

    let queue = [root];
    let level = 0;

    while (queue.length > 0) {
        let size = queue.length;
        let prev = level % 2 === 0 ? -1 : Infinity;

        for (let i = 0; i < size; i++) {
            let node = queue.shift();

            if (level % 2 === 0) {
                if (node.val <= prev || node.val % 2 === 0) return false;
            } else {
                if (node.val >= prev || node.val % 2 === 1) return false;
            }

            prev = node.val;

            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        level++;
    }

    return true;
}
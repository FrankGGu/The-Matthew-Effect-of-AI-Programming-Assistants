var isEvenOddTree = function(root) {
    if (!root) return true;

    let queue = [root];
    let level = 0;

    while (queue.length > 0) {
        let size = queue.length;
        let prevVal = level % 2 === 0 ? -1 : Infinity;

        for (let i = 0; i < size; i++) {
            let node = queue.shift();

            if (level % 2 === 0) {
                if (node.val % 2 === 0 || node.val <= prevVal) {
                    return false;
                }
            } else {
                if (node.val % 2 !== 0 || node.val >= prevVal) {
                    return false;
                }
            }

            prevVal = node.val;

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }

        level++;
    }

    return true;
};
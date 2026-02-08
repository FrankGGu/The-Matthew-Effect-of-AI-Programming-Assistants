var isEvenOddTree = function(root) {
    if (!root) {
        return true;
    }

    let queue = [root];
    let level = 0;

    while (queue.length > 0) {
        let levelSize = queue.length;
        let prevVal = null; 

        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();

            if (level % 2 === 0) { // Even-indexed level (0, 2, 4, ...)
                // Values must be odd
                if (node.val % 2 === 0) {
                    return false;
                }
                // Values must be strictly increasing
                if (prevVal !== null && node.val <= prevVal) {
                    return false;
                }
            } else { // Odd-indexed level (1, 3, 5, ...)
                // Values must be even
                if (node.val % 2 !== 0) {
                    return false;
                }
                // Values must be strictly decreasing
                if (prevVal !== null && node.val >= prevVal) {
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
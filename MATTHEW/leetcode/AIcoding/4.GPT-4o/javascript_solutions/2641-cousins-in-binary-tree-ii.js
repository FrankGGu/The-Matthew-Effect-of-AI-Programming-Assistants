var cousinTree = function(root) {
    if (!root) return null;

    let queue = [root];
    while (queue.length) {
        let size = queue.length;
        let found = false;

        for (let i = 0; i < size; i++) {
            let node = queue.shift();

            if (node.left && node.right) {
                found = true;
            } else {
                if (found) {
                    return null;
                }
            }

            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        if (found) {
            for (let j = 0; j < size; j++) {
                let node = queue.shift();
                if (node.left) node.left = null;
                if (node.right) node.right = null;
                queue.push(node);
            }
        }
    }

    return root;
};
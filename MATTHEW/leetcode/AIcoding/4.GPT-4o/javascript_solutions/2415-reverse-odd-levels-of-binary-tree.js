class TreeNode {
    constructor(val = 0, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var reverseOddLevels = function(root) {
    if (!root) return root;

    const queue = [root];
    let level = 0;

    while (queue.length) {
        const size = queue.length;
        const values = [];

        for (let i = 0; i < size; i++) {
            const node = queue.shift();
            if (node) {
                values.push(node.val);
                if (node.left) queue.push(node.left);
                if (node.right) queue.push(node.right);
            }
        }

        if (level % 2 === 1) {
            for (let i = 0; i < size; i++) {
                queue[i].val = values[size - 1 - i];
            }
        }

        level++;
    }

    return root;
};
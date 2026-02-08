var FindElements = function(root) {
    root.val = 0;
    let queue = [root];
    while (queue.length > 0) {
        let node = queue.shift();
        if (node.left) {
            node.left.val = 2 * node.val + 1;
            queue.push(node.left);
        }
        if (node.right) {
            node.right.val = 2 * node.val + 2;
            queue.push(node.right);
        }
    }
    this.root = root;
};

FindElements.prototype.find = function(target) {
    let path = [];
    while (target > 0) {
        path.push(target % 2);
        target = Math.floor((target - 1) / 2);
    }
    let node = this.root;
    for (let i = path.length - 1; i >= 0; i--) {
        if (path[i] === 0) {
            if (node.left) {
                node = node.left;
            } else {
                return false;
            }
        } else {
            if (node.right) {
                node = node.right;
            } else {
                return false;
            }
        }
    }
    return node !== null;
};
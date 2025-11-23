var CBTInserter = function(root) {
    this.root = root;
    this.queue = [];
    let q = [root];
    while (q.length > 0) {
        let node = q.shift();
        if (!node.left || !node.right) {
            this.queue.push(node);
        }
        if (node.left) {
            q.push(node.left);
        }
        if (node.right) {
            q.push(node.right);
        }
    }
};

CBTInserter.prototype.insert = function(val) {
    let node = new TreeNode(val);
    let parent = this.queue[0];
    if (!parent.left) {
        parent.left = node;
    } else {
        parent.right = node;
        this.queue.shift();
    }
    this.queue.push(node);
    return parent.val;
};

CBTInserter.prototype.get_root = function() {
    return this.root;
};
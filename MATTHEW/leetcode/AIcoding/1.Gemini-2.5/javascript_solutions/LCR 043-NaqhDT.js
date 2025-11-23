var CBTInserter = function(root) {
    this.root = root;
    this.queue = []; 

    let tempQueue = [root];
    while (tempQueue.length > 0) {
        let node = tempQueue.shift();

        if (node.left === null || node.right === null) {
            this.queue.push(node);
        }

        if (node.left !== null) {
            tempQueue.push(node.left);
        }
        if (node.right !== null) {
            tempQueue.push(node.right);
        }
    }
};

CBTInserter.prototype.insert = function(val) {
    let newNode = new TreeNode(val);
    let parent = this.queue[0]; 

    if (parent.left === null) {
        parent.left = newNode;
    } else { 
        parent.right = newNode;
        this.queue.shift();
    }

    this.queue.push(newNode);

    return parent.val;
};

CBTInserter.prototype.get_root = function() {
    return this.root;
};
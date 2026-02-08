class CBTInserter {
    constructor(root) {
        this.root = root;
        this.queue = [];
        this.queue.push(root);
        let node;
        while (this.queue.length) {
            node = this.queue[0];
            if (!node.left || !node.right) break;
            this.queue.push(node.left);
            this.queue.push(node.right);
            this.queue.shift();
        }
    }

    insert(val) {
        const newNode = new TreeNode(val);
        if (this.queue[0].left == null) {
            this.queue[0].left = newNode;
        } else {
            this.queue[0].right = newNode;
            this.queue.shift();
        }
        this.queue.push(newNode);
        return this.root.val;
    }

    get_root() {
        return this.root;
    }
}
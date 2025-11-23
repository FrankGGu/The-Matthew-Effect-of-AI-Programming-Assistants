class CBTInserter {
    constructor(root) {
        this.root = root;
        this.queue = [];
        this.queue.push(root);
        let node = root;
        while (node) {
            if (node.left) {
                this.queue.push(node.left);
            }
            if (node.right) {
                this.queue.push(node.right);
            }
            node = this.queue[0];
            this.queue.shift();
        }
    }

    insert(val) {
        const newNode = new TreeNode(val);
        this.queue.push(newNode);
        const parent = this.queue[0];
        if (!parent.left) {
            parent.left = newNode;
        } else {
            parent.right = newNode;
            this.queue.shift();
        }
        return parent.val;
    }

    get_root() {
        return this.root;
    }
}
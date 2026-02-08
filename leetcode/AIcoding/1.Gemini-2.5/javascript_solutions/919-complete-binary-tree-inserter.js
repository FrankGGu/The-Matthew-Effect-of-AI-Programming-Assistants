class CBTInserter {

    constructor(root) {
        this.root = root;
        this.q = [];

        const bfs_q = [root];
        while (bfs_q.length > 0) {
            const node = bfs_q.shift();

            if (node.left === null || node.right === null) {
                this.q.push(node);
            }

            if (node.left) {
                bfs_q.push(node.left);
            }
            if (node.right) {
                bfs_q.push(node.right);
            }
        }
    }

    insert(val) {
        const parent = this.q[0];
        const newNode = new TreeNode(val);

        if (parent.left === null) {
            parent.left = newNode;
        } else {
            parent.right = newNode;
            this.q.shift();
        }

        this.q.push(newNode);

        return parent.val;
    }

    get_root() {
        return this.root;
    }
}
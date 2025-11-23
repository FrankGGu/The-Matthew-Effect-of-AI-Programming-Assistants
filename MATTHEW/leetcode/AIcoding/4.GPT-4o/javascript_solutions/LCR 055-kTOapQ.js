class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

class BSTIterator {
    constructor(root) {
        this.stack = [];
        this.pushLeft(root);
    }

    pushLeft(node) {
        while (node) {
            this.stack.push(node);
            node = node.left;
        }
    }

    next() {
        const node = this.stack.pop();
        this.pushLeft(node.right);
        return node.val;
    }

    hasNext() {
        return this.stack.length > 0;
    }
}
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
        this._leftmostInorder(root);
    }

    _leftmostInorder(node) {
        while (node) {
            this.stack.push(node);
            node = node.left;
        }
    }

    next() {
        const topNode = this.stack.pop();
        if (topNode.right) {
            this._leftmostInorder(topNode.right);
        }
        return topNode.val;
    }

    hasNext() {
        return this.stack.length > 0;
    }
}
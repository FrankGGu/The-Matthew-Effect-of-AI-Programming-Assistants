class TreeNode {
    constructor(val) {
        this.val = val;
        this.left = null;
        this.right = null;
    }
}

class FindElements {
    constructor(root) {
        this.set = new Set();
        this.recover(root, 0);
    }

    recover(node, value) {
        if (node === null) return;
        node.val = value;
        this.set.add(value);
        this.recover(node.left, 2 * value + 1);
        this.recover(node.right, 2 * value + 2);
    }

    find(target) {
        return this.set.has(target);
    }
}
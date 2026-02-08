class TreeNode {
    constructor(val) {
        this.val = val;
        this.left = this.right = null;
    }
}

class BST {
    constructor() {
        this.root = null;
    }

    insert(val) {
        const newNode = new TreeNode(val);
        if (this.root === null) {
            this.root = newNode;
            return;
        }
        let current = this.root;
        while (true) {
            if (val < current.val) {
                if (current.left === null) {
                    current.left = newNode;
                    return;
                }
                current = current.left;
            } else {
                if (current.right === null) {
                    current.right = newNode;
                    return;
                }
                current = current.right;
            }
        }
    }

    closestNodes(query) {
        const result = [];
        for (let q of query) {
            let lower = null, upper = null;
            this._findClosest(this.root, q, lower, upper);
            result.push([lower, upper]);
        }
        return result;
    }

    _findClosest(node, target, lower, upper) {
        if (node === null) return;
        if (node.val < target) {
            lower = node.val;
            this._findClosest(node.right, target, lower, upper);
        } else if (node.val > target) {
            upper = node.val;
            this._findClosest(node.left, target, lower, upper);
        } else {
            lower = node.val;
            upper = node.val;
        }
    }
}

var closestNodes = function(root, queries) {
    const bst = new BST();
    const inorder = (node) => {
        if (!node) return;
        inorder(node.left);
        bst.insert(node.val);
        inorder(node.right);
    };
    inorder(root);
    return bst.closestNodes(queries);
};
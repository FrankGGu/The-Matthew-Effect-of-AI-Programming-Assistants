class TreeNode {
    constructor(val) {
        this.val = val;
        this.children = [];
    }
}

class Tree {
    constructor(root) {
        this.root = root;
    }

    addChild(parentVal, childVal) {
        const parent = this.findNode(this.root, parentVal);
        if (parent) {
            parent.children.push(new TreeNode(childVal));
        }
    }

    findNode(node, val) {
        if (!node) return null;
        if (node.val === val) return node;
        for (let child of node.children) {
            const found = this.findNode(child, val);
            if (found) return found;
        }
        return null;
    }

    deleteNode(val) {
        if (this.root.val === val) {
            this.root = null;
            return;
        }
        this.deleteNodeHelper(this.root, val);
    }

    deleteNodeHelper(node, val) {
        if (!node) return;
        node.children = node.children.filter(child => {
            if (child.val === val) {
                return false;
            }
            this.deleteNodeHelper(child, val);
            return true;
        });
    }

    getChildren(val) {
        const node = this.findNode(this.root, val);
        return node ? node.children.map(child => child.val) : [];
    }
}
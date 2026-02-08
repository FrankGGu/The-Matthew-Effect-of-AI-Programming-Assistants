class LCTNode {
    constructor(id) {
        this.id = id;
        this.parent = null; // Parent in the splay tree
        this.left = null;   // Left child in the splay tree
        this.right = null;  // Right child in the splay tree
        this.pathParent = null; // Parent in the represented tree if this node is a light child

        this.size = 1;      // Total size of the subtree rooted at this node in the *original* tree
        this.pathSize = 1;  // Size of the preferred path segment represented by this splay tree node
        this.lightChildrenSize = 0; // Sum of sizes of subtrees rooted at light children (in original tree)

        this.lazy = false;  // For path reversal (makeRoot)
    }

    isRoot() {
        return !this.parent || (this.parent.left !== this && this.parent.right !== this);
    }

    isLeftChild() {
        return this.parent && this.parent.left === this;
    }

    isRightChild() {
        return this.parent && this.parent.right === this;
    }

    push() {
        if (this.lazy) {
            [this.left, this.right] = [this.right, this.left];
            if (this.left) this.left.lazy = !this.left.lazy;
            if (this.right) this.right.lazy = !this.right.lazy;
            this.lazy = false;
        }
    }

    update() {
        this.pathSize = 1;
        // The `lightChildrenSize` is updated externally during `access` and `link/cut` operations.
        // It represents the sum of `size` of actual light children in the original tree.
        // This `update` function only aggregates `pathSize` from heavy children and then combines with `lightChildrenSize`.

        if (this.left) {
            this.pathSize += this.left.pathSize;
        }
        if (this.right) {
            this.pathSize += this.right.pathSize;
        }

        this.size = this.pathSize + this.lightChildrenSize;
    }
}

class LinkCutTree {
    constructor(n) {
        this.nodes = Array(n).fill(0).map((_, i) => new LCTNode(i));
    }

    _pushPath(node) {
        if (!node.isRoot()) {
            this._pushPath(node.parent);
        }
        node.push();
    }

    _rotate(x) {
        let p = x.parent;
        let g = p.parent;

        if (!p.isRoot()) {
            if (p.isLeftChild()) g.left = x;
            else g.right = x;
        }
        x.pathParent = p.pathParent;
        p.pathParent = null;

        if (x.isLeftChild()) {
            p.left = x.right;
            if (x.right) x.right.parent = p;
            x.right = p;
        } else {
            p.right = x.left;
            if (x.left) x.left.parent = p;
            x.left = p;
        }
        p.parent = x;
        x.parent = g;

        p.update();
        x.update();
    }

    _splay(x) {
        this._pushPath(x);

        while (!x.isRoot()) {
            let p = x.parent;
            let g = p.parent;
            if (!p.isRoot()) {
                if (x.isLeftChild() === p.isLeftChild()) {
                    this._rotate(p);
                } else {
                    this._rotate(x);
                }
            }
            this._rotate(x);
        }
    }

    access(uNode) {
        let last = null;
        let curr = uNode;

        while (curr) {
            this._splay(curr);

            if (curr.right) {
                curr.lightChildrenSize += curr.right.size;
                curr.right.parent = null;
                curr.right.pathParent = curr;
                curr.right = null;
            }

            if (last) {
                curr.right = last;
                last.parent = curr;
                last.pathParent = null;
                curr.lightChildrenSize -= last.size;
            }

            curr.update();

            last = curr;
            curr = curr.pathParent;
        }
        this._splay(uNode);
        return uNode;
    }

    makeRoot(uNode) {
        this.access(uNode);
        uNode.lazy = !uNode.lazy;
        uNode.push();
    }

    findRoot(uNode) {
        this.access(uNode);
        while (uNode.left) {
            uNode.push();
            uNode = uNode.left;
        }
        this._splay(uNode);
        return uNode;
    }

    link(uNode, vNode) { // Link uNode (child) to vNode (parent)
        this.makeRoot(uNode); // uNode must be root of its tree
        if (this.findRoot(vNode) === uNode) { // u and v are already connected
            return;
        }
        this.access(vNode); // vNode becomes root of its preferred path

        uNode.parent = vNode;
        vNode.lightChildrenSize += uNode.size;
        vNode.update();
    }

    cut(uNode) { // Cut uNode from its parent
        this.access(uNode);
        if (!uNode.left) { // uNode has no parent
            return;
        }

        let pNode = uNode.left;
        uNode.left = null;
        pNode.parent = null;
        pNode.right = null; // This is crucial: pNode's right child (uNode) is detached.

        pNode.update();
        uNode.update();
    }

    querySubtreeSize(uNode) {
        this.access(uNode);
        return uNode.size;
    }
}

function solve(n, initialParents, queries) {
    const lct = new LinkCutTree(n);

    for (let i = 0; i < n; i++) {
        const parentId = initialParents[i];
        if (parentId !== -1) {
            lct.link(lct.nodes[i], lct.nodes[parentId]);
        }
    }

    const results = [];

    for (const query of queries) {
        const type = query[0];
        if (type === 0) { // Reparent u to v
            const u = query[1];
            const v = query[2];

            const uNode = lct.nodes[u];
            const vNode = lct.nodes[v];

            // If u is already connected to v, or v is an ancestor of u, do nothing or handle error.
            // For LeetCode, generally assume valid operations.
            // Check if u and v are already connected (and u is not v).
            if (u === v) continue;
            lct.makeRoot(uNode); // Make u the root of its tree to check connectivity
            if (lct.findRoot(vNode) === uNode) { // v is in u's tree, so v is an ancestor of u. Invalid re-parent.
                continue; 
            }

            // Cut u from its current parent (if it has one)
            lct.cut(uNode);

            // Link u to v
            lct.link(uNode, vNode);

        } else if (type === 1) { // Query subtree size of u
            const u = query[1];
            results.push(lct.querySubtreeSize(lct.nodes[u]));
        }
    }
    return results;
}
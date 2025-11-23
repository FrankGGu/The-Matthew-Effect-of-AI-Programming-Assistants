var BSTIterator = function(root) {
    this.stack = [];
    this._leftmostInorder(root);
};

BSTIterator.prototype._leftmostInorder = function(node) {
    while (node) {
        this.stack.push(node);
        node = node.left;
    }
};

BSTIterator.prototype.next = function() {
    const topmostNode = this.stack.pop();
    if (topmostNode.right) {
        this._leftmostInorder(topmostNode.right);
    }
    return topmostNode.val;
};

BSTIterator.prototype.hasNext = function() {
    return this.stack.length > 0;
};
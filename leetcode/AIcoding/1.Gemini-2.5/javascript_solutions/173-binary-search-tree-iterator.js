var BSTIterator = function(root) {
    this.stack = [];
    this._pushAllLeft(root);
};

BSTIterator.prototype.next = function() {
    let node = this.stack.pop();
    this._pushAllLeft(node.right);
    return node.val;
};

BSTIterator.prototype.hasNext = function() {
    return this.stack.length > 0;
};

BSTIterator.prototype._pushAllLeft = function(node) {
    while (node !== null) {
        this.stack.push(node);
        node = node.left;
    }
};
var BSTIterator = function(root) {
    this.stack = [];
    this.current = root;
};

BSTIterator.prototype.hasNext = function() {
    return this.stack.length > 0 || this.current !== null;
};

BSTIterator.prototype.next = function() {
    while (this.current !== null) {
        this.stack.push(this.current);
        this.current = this.current.left;
    }
    this.current = this.stack.pop();
    var val = this.current.val;
    this.current = this.current.right;
    return val;
};
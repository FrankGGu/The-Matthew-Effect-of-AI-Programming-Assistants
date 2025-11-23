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

var closestNodes = function(root, queries) {
    const iterator = new BSTIterator(root);
    const sorted = [];
    while (iterator.hasNext()) {
        sorted.push(iterator.next());
    }

    const result = [];
    for (const q of queries) {
        let min = -1, max = -1;
        let left = 0, right = sorted.length - 1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (sorted[mid] <= q) {
                min = sorted[mid];
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        left = 0, right = sorted.length - 1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (sorted[mid] >= q) {
                max = sorted[mid];
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        result.push([min, max]);
    }
    return result;
};
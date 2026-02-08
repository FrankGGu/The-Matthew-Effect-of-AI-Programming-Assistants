var NestedIterator = function(nestedList) {
    this.stack = [];
    this.flatten(nestedList);
};

NestedIterator.prototype.flatten = function(nestedList) {
    for (let i = nestedList.length - 1; i >= 0; i--) {
        this.stack.push(nestedList[i]);
    }
};

NestedIterator.prototype.hasNext = function() {
    while (this.stack.length > 0) {
        const top = this.stack[this.stack.length - 1];
        if (top.isInteger()) {
            return true;
        }
        this.stack.pop();
        this.flatten(top.getList());
    }
    return false;
};

NestedIterator.prototype.next = function() {
    if (this.hasNext()) {
        return this.stack.pop().getInteger();
    }
    return null;
};
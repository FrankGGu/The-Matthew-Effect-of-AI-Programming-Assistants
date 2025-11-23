var NestedIterator = function(nestedList) {
    this.stack = [];
    // Push elements in reverse order so that the first element of the list is at the top of the stack
    for (let i = nestedList.length - 1; i >= 0; i--) {
        this.stack.push(nestedList[i]);
    }
};

NestedIterator.prototype.hasNext = function() {
    // While the stack is not empty
    while (this.stack.length > 0) {
        let top = this.stack[this.stack.length - 1]; // Peek at the top element

        // If the top element is an integer, we have a next element
        if (top.isInteger()) {
            return true;
        } else {
            // If the top element is a list, pop it and push its elements onto the stack in reverse order
            this.stack.pop(); // Remove the list
            let list = top.getList();
            for (let i = list.length - 1; i >= 0; i--) {
                this.stack.push(list[i]);
            }
        }
    }
    // If the stack is empty, there are no more elements
    return false;
};

NestedIterator.prototype.next = function() {
    // According to the problem description, next() will only be called when hasNext() is true.
    // Thus, we can assume the top of the stack is an integer.
    let top = this.stack.pop();
    return top.getInteger();
};
var DinnerPlates = function(capacity) {
    this.capacity = capacity;
    this.stacks = [];
    this.left = 0; // first non-full stack
    this.right = -1; // last non-empty stack
};

DinnerPlates.prototype.push = function(val) {
    while (this.left <= this.right && this.stacks[this.left].length === this.capacity) {
        this.left++;
    }
    if (this.left > this.right) {
        this.stacks.push([val]);
        this.left = this.stacks.length - 1;
        this.right = this.stacks.length - 1;
    } else {
        this.stacks[this.left].push(val);
    }
};

DinnerPlates.prototype.pop = function() {
    while (this.right >= 0 && this.stacks[this.right].length === 0) {
        this.right--;
    }
    if (this.right < 0) {
        return -1;
    }
    const val = this.stacks[this.right].pop();
    if (this.left > this.right) {
        this.left = this.right;
    }
    return val;
};

DinnerPlates.prototype.popAtStack = function(index) {
    if (index < 0 || index >= this.stacks.length || this.stacks[index].length === 0) {
        return -1;
    }
    const val = this.stacks[index].pop();
    if (index < this.left) {
        this.left = index;
    }
    return val;
};
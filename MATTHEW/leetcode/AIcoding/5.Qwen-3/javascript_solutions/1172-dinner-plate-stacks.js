var DinnerPlates = function () {
    this.stacks = [];
    this.capacity = 0;
    this.leftmost = 0;
};

DinnerPlates.prototype.push = function (val) {
    if (this.stacks.length === 0) {
        this.stacks.push([val]);
        this.capacity = 1;
        return;
    }

    let i = this.leftmost;
    while (i < this.stacks.length && this.stacks[i].length === this.capacity) {
        i++;
    }

    if (i === this.stacks.length) {
        this.stacks.push([val]);
        this.capacity = this.stacks.length;
    } else {
        this.stacks[i].push(val);
    }
};

DinnerPlates.prototype.pop = function () {
    if (this.stacks.length === 0) return -1;

    let i = this.stacks.length - 1;
    while (i >= 0 && this.stacks[i].length === 0) {
        i--;
    }

    if (i < 0) return -1;

    const val = this.stacks[i].pop();
    if (this.stacks[i].length === 0) {
        this.stacks.splice(i, 1);
        this.leftmost = Math.min(this.leftmost, i);
    }

    return val;
};

DinnerPlates.prototype.popAtStack = function (index) {
    if (index >= this.stacks.length || this.stacks[index].length === 0) return -1;

    const val = this.stacks[index].pop();
    if (this.stacks[index].length === 0) {
        this.stacks.splice(index, 1);
        this.leftmost = Math.min(this.leftmost, index);
    }

    return val;
};
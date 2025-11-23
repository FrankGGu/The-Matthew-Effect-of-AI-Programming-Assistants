class DinnerPlates {
    constructor(capacity) {
        this.capacity = capacity;
        this.stacks = [];
        this.availableStacks = [];
    }

    push(val) {
        while (this.availableStacks.length > 0 && this.availableStacks[0] < this.stacks.length && this.stacks[this.availableStacks[0]].length === this.capacity) {
            this.availableStacks.shift();
        }
        if (this.availableStacks.length === 0) {
            this.stacks.push([val]);
            this.availableStacks.push(this.stacks.length - 1);
        } else {
            this.stacks[this.availableStacks[0]].push(val);
        }
    }

    pop() {
        while (this.stacks.length > 0 && this.stacks[this.stacks.length - 1].length === 0) {
            this.stacks.pop();
        }
        if (this.stacks.length === 0) return -1;
        const val = this.stacks[this.stacks.length - 1].pop();
        if (this.stacks.length - 1 < this.availableStacks[0]) {
            this.availableStacks.unshift(this.stacks.length - 1);
        }
        return val;
    }

    popAtStack(index) {
        if (index < 0 || index >= this.stacks.length || this.stacks[index].length === 0) return -1;
        const val = this.stacks[index].pop();
        if (this.stacks[index].length === this.capacity - 1) {
            this.availableStacks.push(index);
            this.availableStacks.sort((a, b) => a - b);
        }
        return val;
    }
}
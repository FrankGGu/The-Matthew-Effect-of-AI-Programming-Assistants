class DinnerPlates {
    constructor(capacity) {
        this.capacity = capacity;
        this.stacks = [];
        this.available = [];
    }

    push(val) {
        if (this.available.length > 0) {
            let index = this.available.shift();
            this.stacks[index].push(val);
            if (this.stacks[index].length === this.capacity) {
                let i = 0;
                while (i < this.available.length) {
                    if (this.available[i] === index) {
                        this.available.splice(i, 1);
                    } else {
                        i++;
                    }
                }
            }
            return;
        }

        let lastIndex = this.stacks.length - 1;
        if (lastIndex === -1 || this.stacks[lastIndex].length === this.capacity) {
            this.stacks.push([val]);
        } else {
            this.stacks[lastIndex].push(val);
        }
    }

    pop() {
        let lastIndex = this.stacks.length - 1;
        while (lastIndex >= 0 && this.stacks[lastIndex].length === 0) {
            this.stacks.pop();
            lastIndex--;
        }

        if (lastIndex === -1) {
            return -1;
        }

        let val = this.stacks[lastIndex].pop();
        if (this.stacks[lastIndex].length === 0) {
            this.stacks.pop();
        }
        return val;
    }

    popAtStack(index) {
        if (index >= this.stacks.length || this.stacks[index].length === 0) {
            return -1;
        }

        let val = this.stacks[index].pop();
        this.available.push(index);
        this.available.sort((a, b) => a - b);

        let lastIndex = this.stacks.length - 1;
        while (lastIndex >= 0 && this.stacks[lastIndex].length === 0 && lastIndex > index) {
            this.stacks.pop();
            lastIndex--;
        }
        return val;
    }
}
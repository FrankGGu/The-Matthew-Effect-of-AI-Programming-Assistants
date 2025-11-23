class Allocator {
    constructor(n) {
        this.memory = new Array(n).fill(0);
        this.freeList = new Set();
        for (let i = 0; i < n; i++) {
            this.freeList.add(i);
        }
    }

    allocate(size) {
        let count = 0;
        let start = -1;

        for (let i = 0; i < this.memory.length; i++) {
            if (this.memory[i] === 0) {
                if (start === -1) start = i;
                count++;
                if (count === size) {
                    for (let j = start; j < start + size; j++) {
                        this.memory[j] = 1;
                        this.freeList.delete(j);
                    }
                    return start;
                }
            } else {
                start = -1;
                count = 0;
            }
        }
        return -1;
    }

    free(start, size) {
        if (start < 0 || start + size > this.memory.length) return 0;
        let count = 0;

        for (let i = start; i < start + size; i++) {
            if (this.memory[i] === 1) {
                this.memory[i] = 0;
                this.freeList.add(i);
                count++;
            } else {
                break;
            }
        }
        return count;
    }
}
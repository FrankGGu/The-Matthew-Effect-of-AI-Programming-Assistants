class Allocator {
    constructor(n) {
        this.memory = new Array(n).fill(-1);
    }

    allocate(size, mID) {
        let count = 0;
        for (let i = 0; i < this.memory.length; i++) {
            if (this.memory[i] === -1) {
                count++;
                if (count === size) {
                    for (let j = i - size + 1; j <= i; j++) {
                        this.memory[j] = mID;
                    }
                    return i - size + 1;
                }
            } else {
                count = 0;
            }
        }
        return -1;
    }

    free(mID) {
        let freed = 0;
        for (let i = 0; i < this.memory.length; i++) {
            if (this.memory[i] === mID) {
                this.memory[i] = -1;
                freed++;
            }
        }
        return freed;
    }
}
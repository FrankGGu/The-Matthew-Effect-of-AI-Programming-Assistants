class Allocator {
    constructor(n) {
        this.memory = new Array(n).fill(0);
        this.blocks = new Map();
    }

    allocate(size, mID) {
        for (let i = 0; i <= this.memory.length - size; i++) {
            let free = true;
            for (let j = 0; j < size; j++) {
                if (this.memory[i + j] !== 0) {
                    free = false;
                    break;
                }
            }
            if (free) {
                for (let j = 0; j < size; j++) {
                    this.memory[i + j] = mID;
                }
                this.blocks.set(i, { size: size, mID: mID });
                return i;
            }
        }
        return -1;
    }

    free(mID) {
        let freed = 0;
        for (let i = 0; i < this.memory.length; i++) {
            if (this.memory[i] === mID) {
                this.memory[i] = 0;
                freed++;
            }
        }

        let toDelete = [];
        for (let [start, block] of this.blocks) {
            if (block.mID === mID) {
                toDelete.push(start);
            }
        }

        for (let start of toDelete) {
            this.blocks.delete(start);
        }

        return freed;
    }
}
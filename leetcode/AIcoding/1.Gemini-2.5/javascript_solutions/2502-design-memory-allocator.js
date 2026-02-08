class Allocator {
    constructor(n) {
        this.n = n;
        this.memory = new Array(n).fill(0); 
    }

    allocate(size, mID) {
        for (let i = 0; i <= this.n - size; i++) {
            let isAvailable = true;
            for (let j = 0; j < size; j++) {
                if (this.memory[i + j] !== 0) {
                    isAvailable = false;
                    i = i + j; 
                    break;
                }
            }

            if (isAvailable) {
                for (let j = 0; j < size; j++) {
                    this.memory[i + j] = mID;
                }
                return i;
            }
        }
        return -1;
    }

    free(mID) {
        let freedCount = 0;
        for (let i = 0; i < this.n; i++) {
            if (this.memory[i] === mID) {
                this.memory[i] = 0;
                freedCount++;
            }
        }
        return freedCount;
    }
}
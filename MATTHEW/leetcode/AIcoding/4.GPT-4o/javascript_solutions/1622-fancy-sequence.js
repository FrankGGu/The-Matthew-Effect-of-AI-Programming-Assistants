class Fancy {
    constructor() {
        this.nums = [];
        this.adds = [];
        this.muls = [];
        this.mod = 1e9 + 7;
    }

    append(a) {
        this.nums.push(a);
        this.adds.push(0);
        this.muls.push(1);
    }

    addAll(a) {
        this.adds = this.adds.map(x => (x + a) % this.mod);
    }

    multiplyAll(a) {
        this.adds = this.adds.map(x => (x * a) % this.mod);
        this.muls = this.muls.map(x => (x * a) % this.mod);
    }

    getIndex(i) {
        if (i >= this.nums.length) return -1;
        return ((this.nums[i] * this.muls[i]) % this.mod + this.adds[i]) % this.mod;
    }
}
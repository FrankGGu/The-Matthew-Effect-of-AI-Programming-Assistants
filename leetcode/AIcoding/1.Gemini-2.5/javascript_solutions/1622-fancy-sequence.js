class Fancy {
    constructor() {
        this.nums = [];
        this.M_global = 1n;
        this.A_global = 0n;
        this.MOD = 1000000007n;
    }

    append(val) {
        this.nums.push(BigInt(val));
    }

    addAll(inc) {
        this.A_global = (this.A_global + BigInt(inc)) % this.MOD;
    }

    multAll(m) {
        this.M_global = (this.M_global * BigInt(m)) % this.MOD;
        this.A_global = (this.A_global * BigInt(m)) % this.MOD;
    }

    getIndex(idx) {
        if (idx >= this.nums.length) {
            return -1;
        }

        const original_val = this.nums[idx];

        let result = (original_val * this.M_global + this.A_global) % this.MOD;

        return Number(result);
    }
}
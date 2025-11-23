class FenwickTree {
    constructor(maxVal) {
        this.maxVal = maxVal;
        this.tree = new Array(maxVal + 1).fill(0);
    }

    update(idx, delta) {
        while (idx <= this.maxVal) {
            this.tree[idx] += delta;
            idx += idx & (-idx);
        }
    }

    query(idx) {
        let sum = 0;
        while (idx > 0) {
            sum += this.tree[idx];
            idx -= idx & (-idx);
        }
        return sum;
    }
}

var createSortedArray = function(instructions) {
    const MAX_INSTRUCTION_VAL = 100000;
    const bit = new FenwickTree(MAX_INSTRUCTION_VAL);

    let cost = 0;

    for (let i = 0; i < instructions.length; i++) {
        const num = instructions[i];

        const smallerCount = bit.query(num - 1);
        const greaterCount = i - bit.query(num);

        cost += Math.min(smallerCount, greaterCount);

        bit.update(num, 1);
    }

    return cost;
};
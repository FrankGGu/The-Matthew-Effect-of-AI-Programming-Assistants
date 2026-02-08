class FenwickTree {
    constructor(size) {
        this.size = size;
        this.tree = new Array(size + 1).fill(0);
    }

    update(index, delta) {
        while (index <= this.size) {
            this.tree[index] += delta;
            index += index & -index;
        }
    }

    query(index) {
        let sum = 0;
        while (index > 0) {
            sum += this.tree[index];
            index -= index & -index;
        }
        return sum;
    }
}

var createSortedArray = function(instructions) {
    const MOD = 1e9 + 7;
    const maxVal = Math.max(...instructions);
    const fenwickTree = new FenwickTree(maxVal);
    let cost = 0;

    for (let i = 0; i < instructions.length; i++) {
        const num = instructions[i];
        const left = fenwickTree.query(num - 1);
        const right = i - fenwickTree.query(num);
        cost += Math.min(left, right);
        cost %= MOD;
        fenwickTree.update(num, 1);
    }

    return cost;
};
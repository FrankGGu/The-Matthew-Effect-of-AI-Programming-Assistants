class NeighborSumService {
    constructor() {
        this.data = new Map();
    }

    update(index, value) {
        this.data.set(index, value);
    }

    getNeighborSum(index) {
        let sum = 0;

        const leftNeighborValue = this.data.get(index - 1);
        if (leftNeighborValue !== undefined) {
            sum += leftNeighborValue;
        }

        const rightNeighborValue = this.data.get(index + 1);
        if (rightNeighborValue !== undefined) {
            sum += rightNeighborValue;
        }

        return sum;
    }
}
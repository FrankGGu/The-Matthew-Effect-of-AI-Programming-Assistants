class NeighborSumService {
    constructor() {
        this.numbers = [];
    }

    update(index, val) {
        this.numbers[index] = val;
    }

    sum(index) {
        let sum = 0;
        if (index - 1 >= 0) {
            sum += this.numbers[index - 1] || 0;
        }
        if (index + 1 < this.numbers.length) {
            sum += this.numbers[index + 1] || 0;
        }
        return sum;
    }
}
class NeighborSum {
    constructor() {
        this.map = new Map();
    }

    add(pos) {
        if (!this.map.has(pos)) {
            this.map.set(pos, 0);
        }
        this.map.set(pos, this.map.get(pos) + 1);
    }

    remove(pos) {
        if (this.map.has(pos)) {
            this.map.set(pos, this.map.get(pos) - 1);
            if (this.map.get(pos) === 0) {
                this.map.delete(pos);
            }
        }
    }

    getSum(pos) {
        let sum = 0;
        const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];
        for (const [dx, dy] of directions) {
            const neighbor = `${pos[0] + dx},${pos[1] + dy}`;
            if (this.map.has(neighbor)) {
                sum += this.map.get(neighbor);
            }
        }
        return sum;
    }
}
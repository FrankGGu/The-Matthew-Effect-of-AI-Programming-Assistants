class DetectSquares {
    constructor() {
        this.points = {};
    }

    add(point) {
        const [x, y] = point;
        const key = `${x},${y}`;
        if (!this.points[key]) {
            this.points[key] = 0;
        }
        this.points[key]++;
    }

    count(point) {
        const [x, y] = point;
        let count = 0;
        for (const key in this.points) {
            const [px, py] = key.split(',').map(Number);
            if (px !== x && Math.abs(px - x) === Math.abs(py - y)) {
                count += this.points[key] * (this.points[`${x},${py}`] || 0) * (this.points[`${px},${y}`] || 0);
            }
        }
        return count;
    }
}
class DetectSquares {
    constructor() {
        this.points = new Map();
    }

    add(point) {
        const [x, y] = point;
        const key = `${x},${y}`;
        this.points.set(key, (this.points.get(key) || 0) + 1);
    }

    count(point) {
        const [x1, y1] = point;
        let res = 0;
        for (const [key, cnt] of this.points) {
            const [x3, y3] = key.split(',').map(Number);
            if (x1 !== x3 && y1 !== y3 && Math.abs(x1 - x3) === Math.abs(y1 - y3)) {
                const x2 = x1;
                const y2 = y3;
                const x4 = x3;
                const y4 = y1;
                const key2 = `${x2},${y2}`;
                const key4 = `${x4},${y4}`;
                if (this.points.has(key2) && this.points.has(key4)) {
                    res += cnt * (this.points.get(key2) || 0) * (this.points.get(key4) || 0);
                }
            }
        }
        return res;
    }
}
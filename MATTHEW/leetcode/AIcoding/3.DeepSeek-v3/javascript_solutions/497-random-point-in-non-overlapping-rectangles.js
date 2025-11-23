class Solution {
    constructor(rects) {
        this.rects = rects;
        this.prefixSums = [];
        let total = 0;
        for (const rect of rects) {
            const [x1, y1, x2, y2] = rect;
            const area = (x2 - x1 + 1) * (y2 - y1 + 1);
            total += area;
            this.prefixSums.push(total);
        }
        this.total = total;
    }

    pick() {
        const target = Math.floor(Math.random() * this.total);
        let left = 0;
        let right = this.prefixSums.length - 1;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (this.prefixSums[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        const [x1, y1, x2, y2] = this.rects[left];
        const width = x2 - x1 + 1;
        const height = y2 - y1 + 1;
        const base = this.prefixSums[left] - width * height;
        const delta = target - base;
        const x = x1 + (delta % width);
        const y = y1 + Math.floor(delta / width);
        return [x, y];
    }
}
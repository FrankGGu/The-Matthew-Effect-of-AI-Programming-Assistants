class Solution {
    constructor(rectangles) {
        this.rectangles = rectangles;
        this.prefixSums = [];
        let totalArea = 0;

        for (const [x1, y1, x2, y2] of rectangles) {
            const area = (x2 - x1) * (y2 - y1);
            totalArea += area;
            this.prefixSums.push(totalArea);
        }

        this.totalArea = totalArea;
    }

    pick() {
        const target = Math.random() * this.totalArea;
        let left = 0;
        let right = this.prefixSums.length - 1;

        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (this.prefixSums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        const rectIndex = left;
        const [x1, y1, x2, y2] = this.rectangles[rectIndex];
        const areaBefore = rectIndex === 0 ? 0 : this.prefixSums[rectIndex - 1];
        const areaInRectangle = target - areaBefore;

        const width = x2 - x1;
        const height = y2 - y1;
        const ratio = areaInRectangle / ((width * height) / 1);

        const x = x1 + Math.floor(ratio * width);
        const y = y1 + Math.floor((areaInRectangle % (width * height)) / width);

        return [x, y];
    }
}
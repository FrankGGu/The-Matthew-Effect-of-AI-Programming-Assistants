class RangeModule {
    constructor() {
        this.ranges = [];
    }

    addRange(left, right) {
        const newRange = [left, right];
        const updatedRanges = [];
        let i = 0;

        while (i < this.ranges.length && this.ranges[i][1] < left) {
            updatedRanges.push(this.ranges[i]);
            i++;
        }

        while (i < this.ranges.length && this.ranges[i][0] <= right) {
            newRange[0] = Math.min(newRange[0], this.ranges[i][0]);
            newRange[1] = Math.max(newRange[1], this.ranges[i][1]);
            i++;
        }

        updatedRanges.push(newRange);

        while (i < this.ranges.length) {
            updatedRanges.push(this.ranges[i]);
            i++;
        }

        this.ranges = updatedRanges;
    }

    queryRange(left, right) {
        for (const [start, end] of this.ranges) {
            if (start <= left && right <= end) {
                return true;
            }
            if (start > right) {
                break;
            }
        }
        return false;
    }

    removeRange(left, right) {
        const updatedRanges = [];
        for (const [start, end] of this.ranges) {
            if (end <= left) {
                updatedRanges.push([start, end]);
            } else if (start >= right) {
                updatedRanges.push([start, end]);
            } else {
                if (start < left) {
                    updatedRanges.push([start, left]);
                }
                if (end > right) {
                    updatedRanges.push([right, end]);
                }
            }
        }
        this.ranges = updatedRanges;
    }
}
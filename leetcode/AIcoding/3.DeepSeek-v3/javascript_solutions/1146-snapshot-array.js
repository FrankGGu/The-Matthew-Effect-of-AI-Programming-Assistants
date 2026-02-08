class SnapshotArray {
    constructor(length) {
        this.snapId = 0;
        this.array = Array.from({ length }, () => [[0, 0]]);
    }

    set(index, val) {
        const history = this.array[index];
        const lastEntry = history[history.length - 1];
        if (lastEntry[0] === this.snapId) {
            lastEntry[1] = val;
        } else {
            history.push([this.snapId, val]);
        }
    }

    snap() {
        return this.snapId++;
    }

    get(index, snap_id) {
        const history = this.array[index];
        let left = 0;
        let right = history.length - 1;
        let result = 0;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (history[mid][0] <= snap_id) {
                result = history[mid][1];
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }
}
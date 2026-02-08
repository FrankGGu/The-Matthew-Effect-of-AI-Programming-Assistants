class SnapshotArray {
    constructor(length) {
        this.array = Array(length).fill(0);
        this.snapshots = [[...this.array]];
        this.snapId = 0;
    }

    set(index, val) {
        this.array[index] = val;
    }

    snap() {
        this.snapshots.push([...this.array]);
        this.snapId++;
        return this.snapId - 1;
    }

    get(index, snap_id) {
        return this.snapshots[snap_id][index];
    }
}
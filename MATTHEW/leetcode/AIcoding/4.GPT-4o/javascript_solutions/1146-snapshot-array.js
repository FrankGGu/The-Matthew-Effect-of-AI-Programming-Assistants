class SnapshotArray {
    constructor(length) {
        this.snapshots = new Map();
        this.current = new Array(length).fill(0);
        this.snapId = 0;
    }

    set(index, val) {
        this.current[index] = val;
    }

    snap() {
        this.snapshots.set(this.snapId, [...this.current]);
        return this.snapId++;
    }

    get(index, snap_id) {
        if (!this.snapshots.has(snap_id)) return 0;
        for (let i = snap_id; i >= 0; i--) {
            if (this.snapshots.has(i)) {
                return this.snapshots.get(i)[index];
            }
        }
        return 0;
    }
}
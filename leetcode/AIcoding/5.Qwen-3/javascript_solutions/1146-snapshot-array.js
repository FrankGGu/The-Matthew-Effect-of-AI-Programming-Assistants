class SnapshotArray {
    constructor(length) {
        this.snapId = 0;
        this.array = new Array(length).fill(0);
        this.history = [];
        this.current = {};
    }

    set(index, val) {
        this.current[index] = val;
    }

    snap() {
        this.history.push(Object.assign({}, this.current));
        this.snapId++;
        this.current = {};
        return this.snapId - 1;
    }

    get(index, snapId) {
        for (let i = snapId; i >= 0; i--) {
            if (this.history[i] && this.history[i][index] !== undefined) {
                return this.history[i][index];
            }
        }
        return 0;
    }
}
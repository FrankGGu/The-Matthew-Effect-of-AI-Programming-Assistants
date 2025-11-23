var SnapshotArray = function(length) {
    this.history = Array(length).fill(null).map(() => [[0, 0]]);
    this.snap_id = 0;
};

SnapshotArray.prototype.set = function(index, val) {
    const historyForIndex = this.history[index];
    if (historyForIndex[historyForIndex.length - 1][0] === this.snap_id) {
        historyForIndex[historyForIndex.length - 1][1] = val;
    } else {
        historyForIndex.push([this.snap_id, val]);
    }
};

SnapshotArray.prototype.snap = function() {
    return this.snap_id++;
};

SnapshotArray.prototype.get = function(index, snap_id) {
    const historyForIndex = this.history[index];

    let low = 0;
    let high = historyForIndex.length - 1;
    let ansVal = 0;

    while (low <= high) {
        let mid = low + Math.floor((high - low) / 2);
        if (historyForIndex[mid][0] <= snap_id) {
            ansVal = historyForIndex[mid][1];
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return ansVal;
};
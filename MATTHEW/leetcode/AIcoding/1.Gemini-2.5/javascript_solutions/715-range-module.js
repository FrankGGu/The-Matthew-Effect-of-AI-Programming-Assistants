var RangeModule = function() {
    this.intervals = []; // Stores [start, end) intervals, sorted by start, non-overlapping
};

RangeModule.prototype._findFirstIntervalWhoseEndIsGreaterThan = function(val) {
    let low = 0, high = this.intervals.length - 1;
    let ans = this.intervals.length;
    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (this.intervals[mid][1] > val) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
};

RangeModule.prototype._findFirstIntervalWhoseStartIsGreaterThanOrEqualTo = function(val) {
    let low = 0, high = this.intervals.length - 1;
    let ans = this.intervals.length;
    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (this.intervals[mid][0] >= val) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
};

RangeModule.prototype.addRange = function(left, right) {
    let start = left;
    let end = right;

    // Find the first interval whose end is > left. This is the start of potential overlaps.
    let idxOverlapStart = this._findFirstIntervalWhoseEndIsGreaterThan(left);

    // Find the first interval whose start is >= right. This is the end of potential overlaps.
    let idxOverlapEnd = this._findFirstIntervalWhoseStartIsGreaterThanOrEqualTo(right);

    // Merge overlapping intervals
    for (let i = idxOverlapStart; i < idxOverlapEnd; i++) {
        start = Math.min(start, this.intervals[i][0]);
        end = Math.max(end, this.intervals[i][1]);
    }

    // Remove overlapping intervals and insert the new merged one
    this.intervals.splice(idxOverlapStart, idxOverlapEnd - idxOverlapStart, [start, end]);
};

RangeModule.prototype.queryRange = function(left, right) {
    let low = 0, high = this.intervals.length - 1;
    let candidateIdx = -1; // Stores the index of the rightmost interval [s, e) such that s <= left

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        let [s, e] = this.intervals[mid];
        if (s <= left) {
            candidateIdx = mid;
            low = mid + 1; // Try to find an interval starting even further right, but still <= left
        } else {
            high = mid - 1;
        }
    }

    if (candidateIdx !== -1) {
        let [s, e] = this.intervals[candidateIdx];
        if (s <= left && e >= right) {
            return true;
        }
    }
    return false;
};

RangeModule.prototype.removeRange = function(left, right) {
    let newIntervals = [];

    // Find the first interval whose end is > left. This is the start of potential overlaps.
    let idxOverlapStart = this._findFirstIntervalWhoseEndIsGreaterThan(left);

    // Find the first interval whose start is >= right. This is the end of potential overlaps.
    let idxOverlapEnd = this._findFirstIntervalWhoseStartIsGreaterThanOrEqualTo(right);

    // Add intervals completely before the removal range
    for (let i = 0; i < idxOverlapStart; i++) {
        newIntervals.push(this.intervals[i]);
    }

    // Process overlapping intervals
    for (let i = idxOverlapStart; i < idxOverlapEnd; i++) {
        let [s, e] = this.intervals[i];
        if (s < left) { // Part of interval [s, left) remains
            newIntervals.push([s, left]);
        }
        if (e > right) { // Part of interval [right, e) remains
            newIntervals.push([right, e]);
        }
    }

    // Add intervals completely after the removal range
    for (let i = idxOverlapEnd; i < this.intervals.length; i++) {
        newIntervals.push(this.intervals[i]);
    }

    this.intervals = newIntervals;
};
var CountIntervals = function() {
    this.intervals = [];
    this.count = 0;
};

CountIntervals.prototype.add = function(left, right) {
    let newIntervals = [];
    let newLeft = left;
    let newRight = right;
    let added = false;

    for (const [l, r] of this.intervals) {
        if (r < newLeft - 1) {
            newIntervals.push([l, r]);
        } else if (l > newRight + 1) {
            if (!added) {
                newIntervals.push([newLeft, newRight]);
                added = true;
            }
            newIntervals.push([l, r]);
        } else {
            newLeft = Math.min(newLeft, l);
            newRight = Math.max(newRight, r);
        }
    }

    if (!added) {
        newIntervals.push([newLeft, newRight]);
    }

    this.intervals = newIntervals;
    this.count = this.intervals.reduce((sum, [l, r]) => sum + (r - l + 1), 0);
};

CountIntervals.prototype.count = function() {
    return this.count;
};
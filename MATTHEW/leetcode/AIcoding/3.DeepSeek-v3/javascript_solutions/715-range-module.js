var RangeModule = function() {
    this.ranges = [];
};

RangeModule.prototype.addRange = function(left, right) {
    let newRanges = [];
    let inserted = false;
    for (let i = 0; i < this.ranges.length; i++) {
        const [l, r] = this.ranges[i];
        if (r < left) {
            newRanges.push([l, r]);
        } else if (l > right) {
            if (!inserted) {
                newRanges.push([left, right]);
                inserted = true;
            }
            newRanges.push([l, r]);
        } else {
            left = Math.min(left, l);
            right = Math.max(right, r);
        }
    }
    if (!inserted) {
        newRanges.push([left, right]);
    }
    this.ranges = newRanges;
};

RangeModule.prototype.queryRange = function(left, right) {
    let low = 0, high = this.ranges.length - 1;
    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        const [l, r] = this.ranges[mid];
        if (l <= left && right <= r) {
            return true;
        } else if (r < left) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return false;
};

RangeModule.prototype.removeRange = function(left, right) {
    let newRanges = [];
    for (let i = 0; i < this.ranges.length; i++) {
        const [l, r] = this.ranges[i];
        if (r <= left || l >= right) {
            newRanges.push([l, r]);
        } else {
            if (l < left) {
                newRanges.push([l, left]);
            }
            if (r > right) {
                newRanges.push([right, r]);
            }
        }
    }
    this.ranges = newRanges;
};
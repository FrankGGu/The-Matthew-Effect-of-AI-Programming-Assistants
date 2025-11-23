var MajorityChecker = function() {
    this.map = new Map();
    this.nums = [];
};

MajorityChecker.prototype.rangeMajority = function(left, right) {
    let count = 0;
    let candidate = -1;
    for (let i = left; i <= right; i++) {
        if (count === 0) {
            candidate = this.nums[i];
        }
        if (this.nums[i] === candidate) {
            count++;
        } else {
            count--;
        }
    }
    count = 0;
    for (let i = left; i <= right; i++) {
        if (this.nums[i] === candidate) {
            count++;
        }
    }
    return count > (right - left + 1) / 2 ? candidate : -1;
};

MajorityChecker.prototype.query = function(left, right, threshold) {
    let count = 0;
    let candidate = -1;
    for (let i = left; i <= right; i++) {
        if (count === 0) {
            candidate = this.nums[i];
        }
        if (this.nums[i] === candidate) {
            count++;
        } else {
            count--;
        }
    }
    count = 0;
    for (let i = left; i <= right; i++) {
        if (this.nums[i] === candidate) {
            count++;
        }
    }
    return count >= threshold ? candidate : -1;
};

MajorityChecker.prototype.add = function(num) {
    this.nums.push(num);
    if (!this.map.has(num)) {
        this.map.set(num, []);
    }
    this.map.get(num).push(this.nums.length - 1);
};
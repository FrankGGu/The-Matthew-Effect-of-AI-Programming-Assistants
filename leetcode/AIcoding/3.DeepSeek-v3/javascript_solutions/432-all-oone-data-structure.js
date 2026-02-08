var AllOne = function() {
    this.keyCount = new Map();
    this.countKeys = new Map();
    this.minCount = Infinity;
    this.maxCount = -Infinity;
};

AllOne.prototype.inc = function(key) {
    const prevCount = this.keyCount.get(key) || 0;
    const newCount = prevCount + 1;

    this.keyCount.set(key, newCount);

    if (prevCount > 0) {
        const prevKeys = this.countKeys.get(prevCount);
        prevKeys.delete(key);
        if (prevKeys.size === 0) {
            this.countKeys.delete(prevCount);
            if (this.minCount === prevCount) {
                this.minCount++;
            }
        }
    } else {
        if (this.minCount > 1) {
            this.minCount = 1;
        }
    }

    if (!this.countKeys.has(newCount)) {
        this.countKeys.set(newCount, new Set());
    }
    this.countKeys.get(newCount).add(key);

    if (newCount > this.maxCount) {
        this.maxCount = newCount;
    }
};

AllOne.prototype.dec = function(key) {
    if (!this.keyCount.has(key)) return;

    const prevCount = this.keyCount.get(key);
    const newCount = prevCount - 1;

    if (newCount === 0) {
        this.keyCount.delete(key);
    } else {
        this.keyCount.set(key, newCount);
    }

    const prevKeys = this.countKeys.get(prevCount);
    prevKeys.delete(key);
    if (prevKeys.size === 0) {
        this.countKeys.delete(prevCount);
        if (this.maxCount === prevCount) {
            this.maxCount--;
        }
        if (this.minCount === prevCount) {
            this.minCount--;
        }
    }

    if (newCount > 0) {
        if (!this.countKeys.has(newCount)) {
            this.countKeys.set(newCount, new Set());
        }
        this.countKeys.get(newCount).add(key);

        if (newCount < this.minCount) {
            this.minCount = newCount;
        }
    } else {
        if (this.countKeys.size === 0) {
            this.minCount = Infinity;
            this.maxCount = -Infinity;
        }
    }
};

AllOne.prototype.getMaxKey = function() {
    if (this.maxCount === -Infinity) return "";
    const keys = this.countKeys.get(this.maxCount);
    return keys.values().next().value;
};

AllOne.prototype.getMinKey = function() {
    if (this.minCount === Infinity) return "";
    const keys = this.countKeys.get(this.minCount);
    return keys.values().next().value;
};
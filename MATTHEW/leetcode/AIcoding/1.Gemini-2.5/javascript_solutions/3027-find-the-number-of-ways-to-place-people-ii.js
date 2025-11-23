class TreeMap {
    constructor() {
        this.map = new Map();
        this.sortedKeys = []; // Maintains keys in ascending order
    }

    _binarySearchInsertIndex(key) {
        let low = 0, high = this.sortedKeys.length - 1;
        let idx = 0;
        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            if (this.sortedKeys[mid] < key) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return low;
    }

    _binarySearchKeyIndex(key) {
        let low = 0, high = this.sortedKeys.length - 1;
        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            if (this.sortedKeys[mid] === key) {
                return mid;
            } else if (this.sortedKeys[mid] < key) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return -1;
    }

    set(key, value) {
        if (!this.map.has(key)) {
            const idx = this._binarySearchInsertIndex(key);
            this.sortedKeys.splice(idx, 0, key);
        }
        this.map.set(key, value);
    }

    get(key) {
        return this.map.get(key);
    }

    has(key) {
        return this.map.has(key);
    }

    delete(key) {
        if (this.map.delete(key)) {
            const idx = this._binarySearchKeyIndex(key);
            if (idx !== -1) {
                this.sortedKeys.splice(idx, 1);
            }
            return true;
        }
        return false;
    }

    keys() {
        return this.sortedKeys[Symbol.iterator]();
    }

    keysDescending() {
        let current = this.sortedKeys.length - 1;
        const self = this;
        return {
            [Symbol.iterator]() { return this; },
            next() {
                if (current >= 0) {
                    return { value: self.sortedKeys[current--], done: false };
                } else {
                    return { done: true };
                }
            }
        };
    }

    lowerBoundKey(targetKey) {
        const idx = this._binarySearchInsertIndex(targetKey);
        if (idx < this.sortedKeys.length) {
            return this.sortedKeys[idx];
        }
        return null;
    }

    size() {
        return this.map.size;
    }
}

var numberOfPairs = function(points) {
    // Sort points: by x-coordinate ascending, then by y-coordinate ascending.
    // This order is crucial for the sweep-line algorithm.
    points.sort((a, b) => a[0] - b[0] || a[1] - b[1]);

    let ans = 0;
    // activeEnvelope stores (y -> x) pairs.
    // It maintains an "upper-left envelope" of points processed so far.
    // Invariant: for any two points (y_a, x_a) and (y_b, x_b) in activeEnvelope,
    // if y_a < y_b, then x_a > x_b.
    // This means as y-coordinates increase, x-coordinates decrease.
    let activeEnvelope = new TreeMap(); 

    for (let i = 0; i < points.length; i++) {
        const [x_i, y_i] = points[i];

        // 1. Query for p1 candidates:
        // For the current point p_i = (x_i, y_i) to be p2, we need to find p1 = (x_k, y_k)
        // such that x_k <= x_i and y_k >= y_i, and no other point p3 is in the rectangle.
        // The activeEnvelope stores points that form the upper-left envelope.
        // If (y_k, x_k) is in activeEnvelope and y_k >= y_i, then x_k MUST be <= x_i
        // (due to the sorting of points and the maintenance of activeEnvelope).
        // If x_k were > x_i, then (x_k, y_k) would have been dominated by some point
        // with x <= x_i and y >= y_k, or (x_i, y_i) itself.
        // So, we just need to count keys y_k in activeEnvelope where y_k >= y_i.
        for (const y_k of activeEnvelope.keysDescending()) {
            if (y_k < y_i) {
                break; // All remaining keys are smaller than y_i
            }
            ans++;
        }

        // 2. Update activeEnvelope: Add (x_i, y_i) if it's not dominated, and remove dominated points.
        // Check if (x_i, y_i) is dominated by an existing point in activeEnvelope.
        // A point (x_i, y_i) is dominated if there exists (y_k, x_k) in activeEnvelope
        // such that y_k >= y_i and x_k <= x_i.
        // We find the smallest y_k in activeEnvelope that is >= y_i.
        const lowerYKey = activeEnvelope.lowerBoundKey(y_i);
        let isDominated = false;
        if (lowerYKey !== null) {
            // If such a y_k exists, and its corresponding x_k is <= x_i, then (x_i, y_i) is dominated.
            if (activeEnvelope.get(lowerYKey) <= x_i) {
                isDominated = true;
            }
        }

        if (!isDominated) {
            // If (x_i, y_i) is not dominated, add it to activeEnvelope.
            activeEnvelope.set(y_i, x_i);

            // Remove points from activeEnvelope that are now dominated by (x_i, y_i).
            // These are points (y_m, x_m) where y_m < y_i and x_m >= x_i.
            // Due to the activeEnvelope invariant (y increasing, x decreasing),
            // if y_m < y_i, then x_m > x_i.
            // So, we need to remove (y_m, x_m) if y_m < y_i AND x_m >= x_i.
            // Iterate keys in ascending order and collect keys to remove.
            let keysToRemove = [];
            for (const y_m of activeEnvelope.keys()) {
                if (y_m >= y_i) { 
                    break; // Stop when y_m is not strictly less than y_i
                }
                if (activeEnvelope.get(y_m) >= x_i) {
                    keysToRemove.push(y_m);
                }
            }
            for (const y_m of keysToRemove) {
                activeEnvelope.delete(y_m);
            }
        }
    }

    return ans;
};
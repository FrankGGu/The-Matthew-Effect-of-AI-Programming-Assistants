var MajorityChecker = function(arr) {
    this.arr = arr;
    this.valToIndex = new Map();

    for (let i = 0; i < arr.length; i++) {
        const num = arr[i];
        if (!this.valToIndex.has(num)) {
            this.valToIndex.set(num, []);
        }
        this.valToIndex.get(num).push(i);
    }
};

MajorityChecker.prototype.query = function(left, right, threshold) {
    const k = 20; 
    const rangeLength = right - left + 1;

    for (let i = 0; i < k; i++) {
        const randomIndex = left + Math.floor(Math.random() * rangeLength);
        const candidate = this.arr[randomIndex];

        const indices = this.valToIndex.get(candidate);
        if (!indices) continue; 

        const count = this.countOccurrences(indices, left, right);

        if (count >= threshold) {
            return candidate;
        }
    }

    return -1;
};

MajorityChecker.prototype.countOccurrences = function(indices, left, right) {
    let low = 0;
    let high = indices.length;
    let idx1 = indices.length; 
    while (low < high) {
        let mid = Math.floor((low + high) / 2);
        if (indices[mid] >= left) {
            idx1 = mid;
            high = mid;
        } else {
            low = mid + 1;
        }
    }

    low = 0;
    high = indices.length;
    let idx2 = indices.length; 
    while (low < high) {
        let mid = Math.floor((low + high) / 2);
        if (indices[mid] > right) {
            idx2 = mid;
            high = mid;
        } else {
            low = mid + 1;
        }
    }

    return idx2 - idx1;
};
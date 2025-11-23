var RangeFreqQuery = function(arr) {
    this.map = new Map();
    for (let i = 0; i < arr.length; i++) {
        if (!this.map.has(arr[i])) {
            this.map.set(arr[i], []);
        }
        this.map.get(arr[i]).push(i);
    }
};

RangeFreqQuery.prototype.query = function(left, right, value) {
    if (!this.map.has(value)) {
        return 0;
    }
    let indices = this.map.get(value);
    let count = 0;
    let low = 0;
    let high = indices.length - 1;
    let leftIndex = -1;
    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (indices[mid] >= left) {
            leftIndex = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    low = 0;
    high = indices.length - 1;
    let rightIndex = -1;
    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (indices[mid] <= right) {
            rightIndex = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    if (leftIndex === -1 || rightIndex === -1) {
        return 0;
    }

    if (leftIndex > rightIndex) return 0;

    return rightIndex - leftIndex + 1;
};
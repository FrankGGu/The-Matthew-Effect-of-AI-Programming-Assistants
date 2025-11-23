var RangeFreqQuery = function(arr) {
    this.map = {};
    for (let i = 0; i < arr.length; i++) {
        if (!this.map[arr[i]]) {
            this.map[arr[i]] = [];
        }
        this.map[arr[i]].push(i);
    }
};

RangeFreqQuery.prototype.query = function(left, right, value) {
    if (!this.map[value]) return 0;
    const indices = this.map[value];
    const leftIdx = binarySearch(indices, left);
    const rightIdx = binarySearch(indices, right + 1);
    return rightIdx - leftIdx;
};

function binarySearch(arr, target) {
    let left = 0, right = arr.length;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}
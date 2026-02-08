var MajorityChecker = function(arr) {
    this.arr = arr;
    this.n = arr.length;
    this.map = new Map();
    for (let i = 0; i < this.n; i++) {
        if (!this.map.has(arr[i])) {
            this.map.set(arr[i], []);
        }
        this.map.get(arr[i]).push(i);
    }
};

MajorityChecker.prototype.query = function(left, right, threshold) {
    let len = right - left + 1;
    for (let i = 0; i < 20; i++) {
        let index = Math.floor(Math.random() * len) + left;
        let num = this.arr[index];
        let indices = this.map.get(num);
        if (!indices) continue;
        let count = 0;
        let l = 0, r = indices.length - 1;
        while (l <= r) {
            let mid = Math.floor((l + r) / 2);
            if (indices[mid] < left) {
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }
        let leftIndex = l;
        l = 0, r = indices.length - 1;
        while (l <= r) {
            let mid = Math.floor((l + r) / 2);
            if (indices[mid] > right) {
                r = mid - 1;
            } else {
                l = mid + 1;
            }
        }
        let rightIndex = r;
        if (rightIndex >= leftIndex) {
            count = rightIndex - leftIndex + 1;
        }
        if (count >= threshold) {
            return num;
        }
    }
    return -1;
};
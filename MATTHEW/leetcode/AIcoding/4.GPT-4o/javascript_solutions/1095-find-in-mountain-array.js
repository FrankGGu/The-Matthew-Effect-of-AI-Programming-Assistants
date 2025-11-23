class MountainArray {
    constructor(arr) {
        this.arr = arr;
    }

    get(index) {
        return this.arr[index];
    }

    length() {
        return this.arr.length;
    }
}

var findInMountainArray = function(target, mountainArr) {
    const n = mountainArr.length();

    let left = 0, right = n - 1;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (mountainArr.get(mid) < mountainArr.get(mid + 1)) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    const peak = left;

    left = 0;
    right = peak;
    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (mountainArr.get(mid) === target) return mid;
        if (mountainArr.get(mid) < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    left = peak + 1;
    right = n - 1;
    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (mountainArr.get(mid) === target) return mid;
        if (mountainArr.get(mid) > target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return -1;
};
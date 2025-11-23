var findInMountainArray = function(mountainArr, target) {
    let left = 0;
    let right = mountainArr.length - 1;

    // Find peak index
    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (mountainArr[mid] < mountainArr[mid + 1]) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    let peak = left;

    // Search in increasing part
    left = 0;
    right = peak;
    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (mountainArr[mid] === target) {
            return mid;
        } else if (mountainArr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    // Search in decreasing part
    left = peak;
    right = mountainArr.length - 1;
    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (mountainArr[mid] === target) {
            return mid;
        } else if (mountainArr[mid] < target) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return -1;
};
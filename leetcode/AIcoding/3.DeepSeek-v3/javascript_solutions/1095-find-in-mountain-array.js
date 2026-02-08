var findInMountainArray = function(target, mountainArr) {
    const length = mountainArr.length();

    let left = 0;
    let right = length - 1;
    let peak = 0;

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (mountainArr.get(mid) < mountainArr.get(mid + 1)) {
            left = mid + 1;
            peak = mid + 1;
        } else {
            right = mid;
        }
    }

    left = 0;
    right = peak;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const val = mountainArr.get(mid);
        if (val === target) {
            return mid;
        } else if (val < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    left = peak;
    right = length - 1;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const val = mountainArr.get(mid);
        if (val === target) {
            return mid;
        } else if (val > target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return -1;
};
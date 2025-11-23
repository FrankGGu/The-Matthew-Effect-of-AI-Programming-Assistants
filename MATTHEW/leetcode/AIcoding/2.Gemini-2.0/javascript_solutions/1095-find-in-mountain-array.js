var findInMountainArray = function(target, mountainArr) {
    let n = mountainArr.length();
    let peakIndex = findPeakIndex(mountainArr);

    let leftResult = binarySearch(mountainArr, 0, peakIndex, target, true);
    if (leftResult !== -1) {
        return leftResult;
    }

    return binarySearch(mountainArr, peakIndex + 1, n - 1, target, false);

    function findPeakIndex(arr) {
        let left = 0;
        let right = n - 1;

        while (left < right) {
            let mid = Math.floor((left + right) / 2);
            if (arr.get(mid) < arr.get(mid + 1)) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    function binarySearch(arr, left, right, target, ascending) {
        while (left <= right) {
            let mid = Math.floor((left + right) / 2);
            let midVal = arr.get(mid);

            if (midVal === target) {
                return mid;
            }

            if (ascending) {
                if (midVal < target) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            } else {
                if (midVal < target) {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
        }
        return -1;
    }
};
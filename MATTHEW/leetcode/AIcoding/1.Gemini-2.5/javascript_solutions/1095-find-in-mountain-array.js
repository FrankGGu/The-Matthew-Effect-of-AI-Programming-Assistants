var findInMountainArray = function(target, mountainArr) {
    const n = mountainArr.length();

    // Step 1: Find the peak index using binary search
    let low = 0;
    let high = n - 1;
    let peakIndex = -1;

    while (low < high) {
        let mid = low + Math.floor((high - low) / 2);
        // If mid is on the increasing slope, peak is to the right (or mid+1)
        if (mountainArr.get(mid) < mountainArr.get(mid + 1)) {
            low = mid + 1;
        } else {
            // If mid is on the decreasing slope or at the peak, peak is at or to the left
            high = mid;
        }
    }
    peakIndex = low; // low and high converge to the peak index

    // Helper function for binary search
    // Searches a range [start, end] for target, considering if the range is ascending or descending
    const binarySearch = (start, end, isAscending) => {
        let l = start;
        let r = end;
        while (l <= r) {
            let mid = l + Math.floor((r - l) / 2);
            let midVal = mountainArr.get(mid);
            if (midVal === target) {
                return mid;
            }
            if (isAscending) {
                if (midVal < target) {
                    l = mid + 1;
                } else {
                    r = mid - 1;
                }
            } else { // Descending part
                if (midVal > target) {
                    l = mid + 1;
                } else {
                    r = mid - 1;
                }
            }
        }
        return -1;
    };

    // Step 2: Search in the increasing part (from index 0 to peakIndex)
    let result = binarySearch(0, peakIndex, true);
    if (result !== -1) {
        return result;
    }

    // Step 3: Search in the decreasing part (from peakIndex + 1 to n - 1)
    result = binarySearch(peakIndex + 1, n - 1, false);
    return result;
};
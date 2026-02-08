var countTarget = function(scores, target) {
    let left = 0, right = scores.length - 1;
    let first = -1, last = -1;

    // Find first occurrence
    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (scores[mid] >= target) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    first = left;

    left = 0;
    right = scores.length - 1;

    // Find last occurrence
    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (scores[mid] <= target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    last = right;

    if (first <= last) {
        return last - first + 1;
    } else {
        return 0;
    }
};
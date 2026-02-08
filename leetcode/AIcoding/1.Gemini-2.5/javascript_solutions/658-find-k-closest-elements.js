var findClosestElements = function(arr, k, x) {
    let low = 0;
    let high = arr.length - k;

    while (low < high) {
        let mid = low + Math.floor((high - low) / 2);
        // Compare arr[mid] and arr[mid + k]
        // If x - arr[mid] > arr[mid + k] - x, it means arr[mid] is further away from x
        // (or equally far but to the left, which is less preferred than arr[mid+k] if arr[mid+k] is to the right)
        // We want to shift the window to the right, so the starting point must be greater than mid.
        if (x - arr[mid] > arr[mid + k] - x) {
            low = mid + 1;
        } else {
            // arr[mid] is closer or equally close (and smaller if distances are equal)
            // So, mid could be the start of the optimal window, or we might need to shift left.
            high = mid;
        }
    }

    return arr.slice(low, low + k);
};
var findClosestElements = function(arr, k, x) {
    let left = 0;
    let right = arr.length - k;

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (Math.abs(arr[mid] - x) > Math.abs(arr[mid + k] - x)) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return arr.slice(left, left + k);
};
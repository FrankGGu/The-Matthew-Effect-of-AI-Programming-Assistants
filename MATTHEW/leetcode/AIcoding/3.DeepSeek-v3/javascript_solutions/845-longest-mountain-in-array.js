var longestMountain = function(arr) {
    let max = 0;
    const n = arr.length;
    let left = 0;

    while (left < n) {
        let right = left;
        if (right + 1 < n && arr[right] < arr[right + 1]) {
            while (right + 1 < n && arr[right] < arr[right + 1]) {
                right++;
            }
            if (right + 1 < n && arr[right] > arr[right + 1]) {
                while (right + 1 < n && arr[right] > arr[right + 1]) {
                    right++;
                }
                max = Math.max(max, right - left + 1);
            } else {
                right++;
            }
        }
        left = Math.max(right, left + 1);
    }

    return max >= 3 ? max : 0;
};
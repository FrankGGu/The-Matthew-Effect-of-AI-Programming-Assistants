var longestMountain = function(arr) {
    const n = arr.length;
    let maxLen = 0;

    for (let i = 1; i < n - 1; i++) {
        if (arr[i - 1] < arr[i] && arr[i] > arr[i + 1]) {
            let left = i - 1;
            while (left > 0 && arr[left - 1] < arr[left]) {
                left--;
            }

            let right = i + 1;
            while (right < n - 1 && arr[right] > arr[right + 1]) {
                right++;
            }

            maxLen = Math.max(maxLen, right - left + 1);
        }
    }

    return maxLen;
};
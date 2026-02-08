var maximumLength = function(arr, k) {
    let left = 0, right = 0, maxLength = 0, count = 0;

    while (right < arr.length) {
        if (arr[right] > k) count++;

        while (count > 1) {
            if (arr[left] > k) count--;
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
        right++;
    }

    return maxLength;
};
function findLengthOfShortestSubarray(arr) {
    const n = arr.length;
    let left = 0;
    let right = n - 1;

    while (left < n - 1 && arr[left] <= arr[left + 1]) {
        left++;
    }

    if (left === n - 1) return 0;

    while (right > 0 && arr[right - 1] <= arr[right]) {
        right--;
    }

    let minLength = Math.min(n - left - 1, right);

    for (let i = 0; i <= left; i++) {
        while (right < n && arr[i] > arr[right]) {
            right++;
        }
        minLength = Math.min(minLength, right - i - 1);
    }

    return minLength;
}
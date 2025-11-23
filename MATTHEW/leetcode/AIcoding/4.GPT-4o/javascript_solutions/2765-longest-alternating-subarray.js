function longestAlternatingSubarray(arr) {
    let maxLength = 1;
    let currentLength = 1;

    for (let i = 1; i < arr.length; i++) {
        if ((arr[i] - arr[i - 1]) * (arr[i - 1] - arr[i - 2]) < 0) {
            currentLength++;
        } else {
            currentLength = 2;
        }
        maxLength = Math.max(maxLength, currentLength);
    }

    return maxLength;
}
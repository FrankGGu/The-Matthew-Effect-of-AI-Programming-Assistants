var guess = function(num) {
    // This function is provided by the LeetCode environment.
    // Its implementation is hidden and interacts with the picked number.
    // For example purposes, if the picked number was 6:
    // if (num > 6) return -1;
    // if (num < 6) return 1;
    // return 0;
};

var guessNumber = function(n) {
    let low = 1;
    let high = n;

    while (low <= high) {
        let mid = low + Math.floor((high - low) / 2);
        let result = guess(mid);

        if (result === 0) {
            return mid;
        } else if (result === -1) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return -1;
};
var guess = function(num) {
    // This is a placeholder. In LeetCode, this function is predefined.
};

var guessNumber = function(n) {
    let left = 1;
    let right = n;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let result = guess(mid);

        if (result === 0) {
            return mid;
        } else if (result === 1) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
};
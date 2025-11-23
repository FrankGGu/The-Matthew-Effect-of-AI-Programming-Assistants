var guessNumber = function(n) {
    let low = 1;
    let high = n;

    while (low <= high) {
        let mid = Math.floor(low + (high - low) / 2);
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
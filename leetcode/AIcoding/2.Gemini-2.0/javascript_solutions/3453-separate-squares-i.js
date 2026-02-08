var judgeSquareSum = function(n) {
    let left = 0;
    let right = Math.floor(Math.sqrt(n));

    while (left <= right) {
        let sum = left * left + right * right;
        if (sum === n) {
            return true;
        } else if (sum < n) {
            left++;
        } else {
            right--;
        }
    }

    return false;
};
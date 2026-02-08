var findTheNthValueAfterKSeconds = function(n, k) {
    if (n % 2 === 1) {
        if (k % 2 === 0) {
            return n;
        } else {
            return n + 1;
        }
    } else {
        if (k % 2 === 0) {
            return n;
        } else {
            return n - 1;
        }
    }
};
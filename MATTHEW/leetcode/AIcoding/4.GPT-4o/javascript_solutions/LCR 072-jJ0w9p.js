var mySqrt = function(x) {
    if (x < 2) return x;
    let left = 2, right = Math.floor(x / 2);
    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let sq = mid * mid;
        if (sq === x) return mid;
        if (sq < x) left = mid + 1;
        else right = mid - 1;
    }
    return right;
};
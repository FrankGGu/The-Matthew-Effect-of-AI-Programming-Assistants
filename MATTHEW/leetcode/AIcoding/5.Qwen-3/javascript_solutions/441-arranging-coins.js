function arrangeCoins(n) {
    let left = 0, right = n;
    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let total = mid * (mid + 1) / 2;
        if (total === n) return mid;
        else if (total < n) left = mid + 1;
        else right = mid - 1;
    }
    return right;
}
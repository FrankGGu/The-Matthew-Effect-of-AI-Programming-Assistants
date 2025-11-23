function trailingZeroes(n) {
    let count = 0;
    while (n > 0) {
        n = Math.floor(n / 5);
        count += n;
    }
    return count;
}

function findMinK(target) {
    let left = 0, right = 5 * target;
    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (trailingZeroes(mid) < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}

function preimageSizeF1ToN(n) {
    let left = 0, right = 5 * n;
    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (trailingZeroes(mid) < n) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}
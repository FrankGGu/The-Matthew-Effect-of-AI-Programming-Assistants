function minimumBoxes(n) {
    let k = 0;
    while ((k + 1) * (k + 2) / 2 <= n) {
        k++;
    }
    n -= k * (k + 1) / 2;
    let left = 1, right = k;
    while (left < right) {
        let mid = Math.ceil((left + right) / 2);
        if (mid * (mid + 1) / 2 <= n) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }
    return k * (k + 1) / 2 + left;
}
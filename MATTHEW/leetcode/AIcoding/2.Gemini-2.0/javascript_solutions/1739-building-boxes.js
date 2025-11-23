var minimumBoxes = function(n) {
    let k = 0;
    while (k * (k + 1) * (k + 2) / 6 <= n) {
        k++;
    }
    k--;
    n -= k * (k + 1) * (k + 2) / 6;

    let m = 0;
    while (m * (m + 1) / 2 <= n) {
        m++;
    }
    m--;

    return k * (k + 1) / 2 + m * (m + 1) / 2 - (m - 1) * m / 2 + m;
};
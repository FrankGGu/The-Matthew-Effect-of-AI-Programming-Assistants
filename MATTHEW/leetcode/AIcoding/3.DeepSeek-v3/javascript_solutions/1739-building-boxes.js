var minimumBoxes = function(n) {
    let k = 0;
    let total = 0;
    while (total + (k + 1) * (k + 2) / 2 <= n) {
        k++;
        total += k * (k + 1) / 2;
    }

    let res = k * (k + 1) / 2;
    let add = 0;
    while (total < n) {
        add++;
        total += add;
    }
    return res + add;
};
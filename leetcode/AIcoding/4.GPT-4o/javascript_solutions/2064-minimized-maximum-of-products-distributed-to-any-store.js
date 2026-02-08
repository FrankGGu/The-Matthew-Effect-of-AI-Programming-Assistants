var minimizedMaximum = function(n, quantities) {
    let left = 1, right = Math.max(...quantities);

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        let storesNeeded = quantities.reduce((acc, q) => acc + Math.ceil(q / mid), 0);

        if (storesNeeded > n) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
};
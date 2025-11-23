function minimizedMaximum(quantities, n) {
    let left = 1, right = Math.max(...quantities);

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        let count = 0;

        for (let q of quantities) {
            count += Math.ceil(q / mid);
        }

        if (count > n) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}
var minimizedMaximum = function(n, quantities) {
    let left = 1;
    let right = Math.max(...quantities);

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        let stores = 0;

        for (const q of quantities) {
            stores += Math.ceil(q / mid);
        }

        if (stores > n) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
};
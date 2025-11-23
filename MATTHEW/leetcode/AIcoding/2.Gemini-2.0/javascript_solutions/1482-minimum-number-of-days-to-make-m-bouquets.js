var minDays = function(bloomDay, m, k) {
    if (bloomDay.length < m * k) {
        return -1;
    }

    let left = 1;
    let right = Math.max(...bloomDay);

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        let bouquets = 0;
        let flowers = 0;

        for (let day of bloomDay) {
            if (day <= mid) {
                flowers++;
                if (flowers === k) {
                    bouquets++;
                    flowers = 0;
                }
            } else {
                flowers = 0;
            }
        }

        if (bouquets >= m) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
};
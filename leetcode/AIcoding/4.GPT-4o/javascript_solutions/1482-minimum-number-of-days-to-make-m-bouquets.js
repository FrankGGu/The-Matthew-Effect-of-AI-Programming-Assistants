var minDays = function(bloomDay, m, k) {
    if (m * k > bloomDay.length) return -1;

    let left = Math.min(...bloomDay), right = Math.max(...bloomDay);

    const canMakeBouquets = (days) => {
        let bouquets = 0, flowers = 0;
        for (let bloom of bloomDay) {
            if (bloom <= days) {
                flowers++;
                if (flowers === k) {
                    bouquets++;
                    flowers = 0;
                }
            } else {
                flowers = 0;
            }
        }
        return bouquets >= m;
    };

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (canMakeBouquets(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
};
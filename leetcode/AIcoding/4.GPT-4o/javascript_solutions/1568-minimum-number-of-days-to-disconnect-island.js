var minDays = function(bloomDay, m, k) {
    const n = bloomDay.length;
    if (m * k > n) return -1;

    const canMakeBouquets = (days) => {
        let bouquets = 0, flowers = 0;
        for (const bloom of bloomDay) {
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

    let left = 1, right = Math.max(...bloomDay);
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (canMakeBouquets(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
};
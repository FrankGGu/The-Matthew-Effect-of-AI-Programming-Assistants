function shipWithinDays(weights, days) {
    function canShip(capacity) {
        let daysUsed = 1;
        let currentWeight = 0;
        for (let weight of weights) {
            if (currentWeight + weight > capacity) {
                daysUsed++;
                currentWeight = weight;
            } else {
                currentWeight += weight;
            }
        }
        return daysUsed <= days;
    }

    let left = Math.max(...weights);
    let right = weights.reduce((a, b) => a + b, 0);

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (canShip(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}
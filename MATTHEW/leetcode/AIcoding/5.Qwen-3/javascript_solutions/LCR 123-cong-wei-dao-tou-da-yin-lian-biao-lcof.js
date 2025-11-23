function shipWithinDays(weights, D) {
    let left = Math.max(...weights);
    let right = weights.reduce((a, b) => a + b, 0);

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        let days = 1;
        let currentWeight = 0;

        for (let weight of weights) {
            if (currentWeight + weight > mid) {
                days++;
                currentWeight = weight;
            } else {
                currentWeight += weight;
            }
        }

        if (days > D) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}
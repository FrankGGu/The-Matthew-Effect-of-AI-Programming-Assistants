function shipWithinDays(weights, D) {
    let left = Math.max(...weights);
    let right = weights.reduce((a, b) => a + b, 0);

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        let count = 1;
        let current = 0;

        for (let weight of weights) {
            if (current + weight > mid) {
                count++;
                current = weight;
            } else {
                current += weight;
            }
        }

        if (count > D) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}
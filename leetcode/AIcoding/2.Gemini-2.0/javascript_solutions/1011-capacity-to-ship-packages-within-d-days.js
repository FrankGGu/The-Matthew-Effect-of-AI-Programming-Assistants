var shipWithinDays = function(weights, days) {
    let left = Math.max(...weights);
    let right = weights.reduce((sum, weight) => sum + weight, 0);

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        let daysNeeded = 1;
        let currentWeight = 0;

        for (let weight of weights) {
            if (currentWeight + weight > mid) {
                daysNeeded++;
                currentWeight = 0;
            }
            currentWeight += weight;
        }

        if (daysNeeded > days) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
};
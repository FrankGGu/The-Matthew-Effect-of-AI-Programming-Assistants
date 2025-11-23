var shipWithinDays = function(weights, days) {
    let left = Math.max(...weights);
    let right = weights.reduce((a, b) => a + b, 0);

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        let current = 0;
        let requiredDays = 1;

        for (const weight of weights) {
            if (current + weight > mid) {
                requiredDays++;
                current = 0;
            }
            current += weight;
        }

        if (requiredDays > days) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
};
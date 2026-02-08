var minTimeToRepairCars = function(ranks, cars) {
    const check = (time) => {
        let totalCarsRepaired = 0;
        for (const r of ranks) {
            // r * k^2 <= time
            // k^2 <= time / r
            // k = floor(sqrt(time / r))
            const k = Math.floor(Math.sqrt(time / r));
            totalCarsRepaired += k;
            if (totalCarsRepaired >= cars) {
                return true;
            }
        }
        return totalCarsRepaired >= cars;
    };

    let low = 1;
    let maxRank = 0;
    for (const r of ranks) {
        if (r > maxRank) {
            maxRank = r;
        }
    }
    // The maximum possible time occurs when the highest-ranked mechanic (largest r) repairs all cars.
    // r * cars^2
    let high = maxRank * cars * cars;
    let ans = high;

    while (low <= high) {
        const mid = Math.floor(low + (high - low) / 2);
        if (check(mid)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};
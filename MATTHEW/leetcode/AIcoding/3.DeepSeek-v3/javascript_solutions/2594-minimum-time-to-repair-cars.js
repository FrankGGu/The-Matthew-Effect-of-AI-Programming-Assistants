var repairCars = function(ranks, cars) {
    let left = 1;
    let right = Math.min(...ranks) * cars * cars;

    const canRepair = (time) => {
        let total = 0;
        for (const rank of ranks) {
            total += Math.floor(Math.sqrt(time / rank));
            if (total >= cars) return true;
        }
        return false;
    };

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (canRepair(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
};
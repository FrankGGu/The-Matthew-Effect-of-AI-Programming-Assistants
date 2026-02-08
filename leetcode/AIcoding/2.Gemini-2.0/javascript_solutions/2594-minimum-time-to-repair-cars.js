var repairCars = function(ranks, cars) {
    let low = 0;
    let high = Math.max(...ranks) * cars * cars;
    let ans = high;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        let repairedCars = 0;
        for (let rank of ranks) {
            repairedCars += Math.floor(Math.sqrt(mid / rank));
        }

        if (repairedCars >= cars) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};
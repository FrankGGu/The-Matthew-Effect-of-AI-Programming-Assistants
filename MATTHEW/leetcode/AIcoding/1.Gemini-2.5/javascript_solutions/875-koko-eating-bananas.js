var minEatingSpeed = function(piles, h) {
    let low = 1;
    let high = Math.max(...piles);
    let ans = high;

    while (low <= high) {
        let mid = Math.floor(low + (high - low) / 2);
        let hoursNeeded = 0;
        for (let pile of piles) {
            hoursNeeded += Math.ceil(pile / mid);
        }

        if (hoursNeeded <= h) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};
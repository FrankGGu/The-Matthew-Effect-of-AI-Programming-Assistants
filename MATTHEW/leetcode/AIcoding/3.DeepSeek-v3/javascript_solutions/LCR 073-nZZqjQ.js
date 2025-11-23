var minEatingSpeed = function(piles, h) {
    let left = 1;
    let right = Math.max(...piles);

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        let total = 0;

        for (const pile of piles) {
            total += Math.ceil(pile / mid);
        }

        if (total > h) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
};
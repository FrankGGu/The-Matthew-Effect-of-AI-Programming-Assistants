var minEatingSpeed = function(piles, H) {
    let left = 1, right = Math.max(...piles);

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        let hours = piles.reduce((acc, pile) => acc + Math.ceil(pile / mid), 0);

        if (hours <= H) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
};
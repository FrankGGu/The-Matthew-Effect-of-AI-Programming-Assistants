var maximumCandies = function(candies, k) {
    let left = 0;
    let right = Math.max(...candies);
    let result = 0;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (mid === 0) {
            left = mid + 1;
            continue;
        }
        let total = 0;
        for (let pile of candies) {
            total += Math.floor(pile / mid);
        }
        if (total >= k) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
};
var maximumCandies = function(candies, k) {
    let left = 0;
    let right = Math.max(...candies);
    let ans = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (mid === 0) {
            return Math.max(0, ans);
        }

        let count = 0;
        for (const candy of candies) {
            count += Math.floor(candy / mid);
        }

        if (count >= k) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
};
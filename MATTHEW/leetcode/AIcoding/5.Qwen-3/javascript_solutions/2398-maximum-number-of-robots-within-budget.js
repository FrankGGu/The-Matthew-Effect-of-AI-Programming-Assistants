function maxRobots(prices, budget) {
    const n = prices.length;
    let left = 0;
    let right = 0;
    let total = 0;
    let count = 0;

    while (right < n) {
        total += prices[right];
        while (total > budget) {
            total -= prices[left];
            left++;
        }
        count = Math.max(count, right - left + 1);
        right++;
    }

    return count;
}
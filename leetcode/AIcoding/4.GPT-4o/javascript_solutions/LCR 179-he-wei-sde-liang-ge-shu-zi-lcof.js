function twoSum(prices, target) {
    const map = new Map();
    for (let i = 0; i < prices.length; i++) {
        const complement = target - prices[i];
        if (map.has(complement)) {
            return [map.get(complement), i];
        }
        map.set(prices[i], i);
    }
    return [];
}
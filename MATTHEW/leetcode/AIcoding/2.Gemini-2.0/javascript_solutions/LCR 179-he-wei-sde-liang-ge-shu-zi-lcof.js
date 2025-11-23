var twoSum = function(price, target) {
    const map = new Map();
    for (let i = 0; i < price.length; i++) {
        const complement = target - price[i];
        if (map.has(complement)) {
            return [map.get(complement), i];
        }
        map.set(price[i], i);
    }
    return [];
};
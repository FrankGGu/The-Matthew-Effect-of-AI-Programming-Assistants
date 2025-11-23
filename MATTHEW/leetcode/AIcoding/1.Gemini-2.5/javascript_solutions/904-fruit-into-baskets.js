var totalFruit = function(fruits) {
    let maxLen = 0;
    let left = 0;
    const basket = new Map();

    for (let right = 0; right < fruits.length; right++) {
        const fruit = fruits[right];
        basket.set(fruit, (basket.get(fruit) || 0) + 1);

        while (basket.size > 2) {
            const leftFruit = fruits[left];
            basket.set(leftFruit, basket.get(leftFruit) - 1);
            if (basket.get(leftFruit) === 0) {
                basket.delete(leftFruit);
            }
            left++;
        }
        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
};
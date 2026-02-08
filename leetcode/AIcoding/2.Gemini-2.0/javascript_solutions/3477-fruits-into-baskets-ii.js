var totalFruit = function(fruits) {
    let left = 0;
    let right = 0;
    let basket = new Map();
    let maxLen = 0;

    while (right < fruits.length) {
        basket.set(fruits[right], (basket.get(fruits[right]) || 0) + 1);

        while (basket.size > 2) {
            basket.set(fruits[left], basket.get(fruits[left]) - 1);
            if (basket.get(fruits[left]) === 0) {
                basket.delete(fruits[left]);
            }
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
        right++;
    }

    return maxLen;
};
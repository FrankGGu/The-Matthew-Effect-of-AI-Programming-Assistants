var totalFruits = function(fruits) {
    let left = 0, right = 0;
    let maxCount = 0;
    const fruitCount = new Map();

    while (right < fruits.length) {
        fruitCount.set(fruits[right], (fruitCount.get(fruits[right]) || 0) + 1);

        while (fruitCount.size > 2) {
            fruitCount.set(fruits[left], fruitCount.get(fruits[left]) - 1);
            if (fruitCount.get(fruits[left]) === 0) {
                fruitCount.delete(fruits[left]);
            }
            left++;
        }

        maxCount = Math.max(maxCount, right - left + 1);
        right++;
    }

    return maxCount;
};
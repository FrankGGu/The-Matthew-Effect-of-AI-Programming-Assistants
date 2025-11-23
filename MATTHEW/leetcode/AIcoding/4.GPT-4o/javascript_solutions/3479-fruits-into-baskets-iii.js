var totalFruits = function(fruits) {
    let left = 0, right = 0, maxFruits = 0;
    const count = new Map();

    while (right < fruits.length) {
        count.set(fruits[right], (count.get(fruits[right]) || 0) + 1);

        while (count.size > 2) {
            count.set(fruits[left], count.get(fruits[left]) - 1);
            if (count.get(fruits[left]) === 0) {
                count.delete(fruits[left]);
            }
            left++;
        }

        maxFruits = Math.max(maxFruits, right - left + 1);
        right++;
    }

    return maxFruits;
};
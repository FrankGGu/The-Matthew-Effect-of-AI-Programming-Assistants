var totalFruit = function(fruits) {
    let left = 0;
    let maxLen = 0;
    const fruitCounts = new Map();

    for (let right = 0; right < fruits.length; right++) {
        const currentFruit = fruits[right];
        fruitCounts.set(currentFruit, (fruitCounts.get(currentFruit) || 0) + 1);

        while (fruitCounts.size > 2) {
            const leftFruit = fruits[left];
            fruitCounts.set(leftFruit, fruitCounts.get(leftFruit) - 1);
            if (fruitCounts.get(leftFruit) === 0) {
                fruitCounts.delete(leftFruit);
            }
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
};
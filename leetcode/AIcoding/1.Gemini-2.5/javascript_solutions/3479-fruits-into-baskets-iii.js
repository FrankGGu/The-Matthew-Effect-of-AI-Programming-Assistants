function totalFruit(fruits) {
    let k = 3; 
    let windowStart = 0;
    let maxLength = 0;
    const fruitFrequency = new Map();

    for (let windowEnd = 0; windowEnd < fruits.length; windowEnd++) {
        const rightFruit = fruits[windowEnd];
        fruitFrequency.set(rightFruit, (fruitFrequency.get(rightFruit) || 0) + 1);

        while (fruitFrequency.size > k) {
            const leftFruit = fruits[windowStart];
            fruitFrequency.set(leftFruit, fruitFrequency.get(leftFruit) - 1);
            if (fruitFrequency.get(leftFruit) === 0) {
                fruitFrequency.delete(leftFruit);
            }
            windowStart++;
        }

        maxLength = Math.max(maxLength, windowEnd - windowStart + 1);
    }

    return maxLength;
}
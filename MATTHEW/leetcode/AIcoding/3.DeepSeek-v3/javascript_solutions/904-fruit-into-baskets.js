var totalFruit = function(fruits) {
    let max = 0;
    let start = 0;
    const map = new Map();

    for (let end = 0; end < fruits.length; end++) {
        const fruit = fruits[end];
        map.set(fruit, (map.get(fruit) || 0) + 1);

        while (map.size > 2) {
            const startFruit = fruits[start];
            map.set(startFruit, map.get(startFruit) - 1);
            if (map.get(startFruit) === 0) {
                map.delete(startFruit);
            }
            start++;
        }

        max = Math.max(max, end - start + 1);
    }

    return max;
};
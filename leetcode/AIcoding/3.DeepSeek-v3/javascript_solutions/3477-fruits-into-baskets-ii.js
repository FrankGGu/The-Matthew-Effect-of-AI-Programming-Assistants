var totalFruit = function(fruits) {
    let max = 0;
    let start = 0;
    let map = new Map();

    for (let end = 0; end < fruits.length; end++) {
        let fruit = fruits[end];
        map.set(fruit, (map.get(fruit) || 0) + 1);

        while (map.size > 2) {
            let leftFruit = fruits[start];
            map.set(leftFruit, map.get(leftFruit) - 1);
            if (map.get(leftFruit) === 0) {
                map.delete(leftFruit);
            }
            start++;
        }

        max = Math.max(max, end - start + 1);
    }

    return max;
};
var totalFruit = function(fruits) {
    let maxLen = 0;
    let start = 0;
    let map = new Map();

    for (let end = 0; end < fruits.length; end++) {
        map.set(fruits[end], (map.get(fruits[end]) || 0) + 1);

        while (map.size > 2) {
            map.set(fruits[start], map.get(fruits[start]) - 1);
            if (map.get(fruits[start]) === 0) {
                map.delete(fruits[start]);
            }
            start++;
        }

        maxLen = Math.max(maxLen, end - start + 1);
    }

    return maxLen;
};
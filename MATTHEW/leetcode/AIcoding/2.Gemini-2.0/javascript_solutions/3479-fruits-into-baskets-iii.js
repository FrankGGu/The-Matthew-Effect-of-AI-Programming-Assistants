var totalFruit = function(fruits) {
    let maxLen = 0;
    let left = 0;
    let fruitCount = {};
    let distinctFruits = 0;

    for (let right = 0; right < fruits.length; right++) {
        if (fruitCount[fruits[right]] === undefined) {
            fruitCount[fruits[right]] = 0;
        }
        if (fruitCount[fruits[right]] === 0) {
            distinctFruits++;
        }
        fruitCount[fruits[right]]++;

        while (distinctFruits > 2) {
            fruitCount[fruits[left]]--;
            if (fruitCount[fruits[left]] === 0) {
                distinctFruits--;
            }
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
};
var maxFruitCount = function (tree) {
    let left = 0;
    let right = 0;
    const fruitCount = new Map();
    let maxFruits = 0;

    while (right < tree.length) {
        fruitCount.set(tree[right], (fruitCount.get(tree[right]) || 0) + 1);

        while (fruitCount.size > 2) {
            fruitCount.set(tree[left], fruitCount.get(tree[left]) - 1);
            if (fruitCount.get(tree[left]) === 0) {
                fruitCount.delete(tree[left]);
            }
            left++;
        }

        maxFruits = Math.max(maxFruits, right - left + 1);
        right++;
    }

    return maxFruits;
};
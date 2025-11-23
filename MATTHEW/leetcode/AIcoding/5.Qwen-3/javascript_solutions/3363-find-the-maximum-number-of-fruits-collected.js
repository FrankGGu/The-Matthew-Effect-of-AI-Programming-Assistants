function maxTotalFruits(basket, k) {
    let n = basket.length;
    let left = 0;
    let total = 0;
    let count = new Map();
    let maxFruits = 0;

    for (let right = 0; right < n; right++) {
        if (basket[right] > 0) {
            count.set(basket[right], (count.get(basket[right]) || 0) + 1);
        }
        total += basket[right];

        while (count.size > k) {
            if (basket[left] > 0) {
                count.set(basket[left], count.get(basket[left]) - 1);
                if (count.get(basket[left]) === 0) {
                    count.delete(basket[left]);
                }
            }
            total -= basket[left];
            left++;
        }

        maxFruits = Math.max(maxFruits, total);
    }

    return maxFruits;
}
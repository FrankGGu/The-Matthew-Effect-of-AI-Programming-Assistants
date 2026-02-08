var maxFruits = function(fruits, k) {
    let left = 0, right = 0, maxFruits = 0, currentFruits = 0;
    const n = fruits.length;

    while (right < n) {
        currentFruits += fruits[right];

        while (right - left + 1 > k) {
            currentFruits -= fruits[left];
            left++;
        }

        maxFruits = Math.max(maxFruits, currentFruits);
        right++;
    }

    return maxFruits;
};
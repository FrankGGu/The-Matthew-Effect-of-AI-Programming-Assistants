var maxTotalFruits = function(fruits, startPos, k) {
    let left = 0;
    let right = 0;
    let n = fruits.length;
    let sum = 0;
    let maxFruits = 0;

    while (right < n) {
        sum += fruits[right][1];

        while (left <= right && (Math.abs(fruits[left][0] - startPos) + Math.abs(fruits[right][0] - startPos) + Math.min(Math.abs(fruits[left][0] - startPos), Math.abs(fruits[right][0] - startPos)) > k)) {
            sum -= fruits[left][1];
            left++;
        }

        maxFruits = Math.max(maxFruits, sum);
        right++;
    }

    return maxFruits;
};
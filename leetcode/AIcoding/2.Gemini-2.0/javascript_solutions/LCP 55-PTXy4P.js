var maxTotalFruits = function(fruits, startPos, k) {
    let n = fruits.length;
    let left = 0;
    let right = 0;
    let sum = 0;
    let maxFruits = 0;

    while (right < n) {
        sum += fruits[right][1];

        while (left <= right && Math.min(Math.abs(fruits[left][0] - startPos) + Math.abs(fruits[right][0] - startPos) + (fruits[right][0] - fruits[left][0]), Math.abs(fruits[right][0] - startPos) + Math.abs(fruits[left][0] - startPos) + (fruits[right][0] - fruits[left][0])) > k) {
            sum -= fruits[left][1];
            left++;
        }

        maxFruits = Math.max(maxFruits, sum);
        right++;
    }

    return maxFruits;
};
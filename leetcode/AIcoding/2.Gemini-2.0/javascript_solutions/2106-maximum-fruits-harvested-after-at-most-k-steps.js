var maxTotalFruits = function(fruits, startPos, k) {
    let n = fruits.length;
    let prefixSum = new Array(n + 1).fill(0);
    let left = 0, right = 0;
    let maxFruits = 0;

    while (right < n) {
        while (left < right &&
               Math.min(Math.abs(fruits[left][0] - startPos) + Math.abs(fruits[right][0] - fruits[left][0]),
                        Math.abs(fruits[right][0] - startPos) + Math.abs(fruits[right][0] - fruits[left][0])) > k) {
            left++;
        }

        let dist = Math.min(Math.abs(fruits[left][0] - startPos) + Math.abs(fruits[right][0] - fruits[left][0]),
                             Math.abs(fruits[right][0] - startPos) + Math.abs(fruits[right][0] - fruits[left][0]));

        if (dist <= k) {
            let currentFruits = 0;
            for (let i = left; i <= right; i++) {
                currentFruits += fruits[i][1];
            }
            maxFruits = Math.max(maxFruits, currentFruits);
        }
        right++;
    }

    return maxFruits;
};
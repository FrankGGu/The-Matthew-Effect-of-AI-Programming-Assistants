var maxTotalFruits = function(fruits, startPos, k) {
    let left = 0;
    let right = 0;
    let maxFruits = 0;
    let currentSum = 0;
    const n = fruits.length;

    const prefixSum = [0];
    const positions = [];
    for (const [pos, amount] of fruits) {
        prefixSum.push(prefixSum[prefixSum.length - 1] + amount);
        positions.push(pos);
    }

    for (right = 0; right < n; right++) {
        if (positions[right] > startPos + k) break;
        if (positions[right] < startPos - k) continue;

        while (left <= right) {
            const minSteps = Math.min(
                Math.abs(startPos - positions[left]) + positions[right] - positions[left],
                Math.abs(startPos - positions[right]) + positions[right] - positions[left]
            );
            if (minSteps <= k) break;
            left++;
        }

        currentSum = prefixSum[right + 1] - prefixSum[left];
        if (currentSum > maxFruits) {
            maxFruits = currentSum;
        }
    }

    return maxFruits;
};
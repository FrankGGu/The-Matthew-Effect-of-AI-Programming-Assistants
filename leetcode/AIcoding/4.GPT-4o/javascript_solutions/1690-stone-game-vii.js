var stoneGameVII = function(stones) {
    const n = stones.length;
    const prefixSum = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + stones[i];
    }

    let left = 0, right = n - 1;
    let aliceScore = 0, bobScore = 0;

    while (left < right) {
        if (prefixSum[right + 1] - prefixSum[left + 1] > prefixSum[right] - prefixSum[left]) {
            aliceScore += stones[left];
            left++;
        } else {
            aliceScore += stones[right];
            right--;
        }
    }

    return aliceScore;
};
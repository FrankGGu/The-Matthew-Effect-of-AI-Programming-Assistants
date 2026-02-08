function findBestSubarray(nums, K) {
    let closest = Infinity;
    let bestL = -1, bestR = -1;
    const n = nums.length;

    for (let l = 0; l < n; l++) {
        let currentOr = 0;
        for (let r = l; r < n; r++) {
            currentOr |= nums[r];
            if (Math.abs(currentOr - K) < Math.abs(closest - K)) {
                closest = currentOr;
                bestL = l;
                bestR = r;
            }
        }
    }

    return [bestL, bestR];
}
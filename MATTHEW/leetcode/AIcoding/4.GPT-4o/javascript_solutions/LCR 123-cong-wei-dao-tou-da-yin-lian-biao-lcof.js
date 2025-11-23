function numMovesToMakeZigzag(nums) {
    let n = nums.length;
    let movesEven = 0, movesOdd = 0;

    for (let i = 0; i < n; i++) {
        let left = i > 0 ? nums[i - 1] : Infinity;
        let right = i < n - 1 ? nums[i + 1] : Infinity;
        let minNeighbor = Math.min(left, right);

        if (nums[i] >= minNeighbor) {
            if (i % 2 === 0) {
                movesEven += nums[i] - minNeighbor + 1;
            } else {
                movesOdd += nums[i] - minNeighbor + 1;
            }
        }
    }

    return Math.min(movesEven, movesOdd);
}
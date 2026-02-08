var movesToMakeZigzag = function(nums) {
    let evenMoves = 0;
    let oddMoves = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        let left = i > 0 ? nums[i - 1] : Infinity;
        let right = i < n - 1 ? nums[i + 1] : Infinity;
        let min = Math.min(left, right);

        if (i % 2 === 0) {
            if (nums[i] >= min) {
                evenMoves += nums[i] - min + 1;
            }
        } else {
            if (nums[i] >= min) {
                oddMoves += nums[i] - min + 1;
            }
        }
    }

    return Math.min(evenMoves, oddMoves);
};
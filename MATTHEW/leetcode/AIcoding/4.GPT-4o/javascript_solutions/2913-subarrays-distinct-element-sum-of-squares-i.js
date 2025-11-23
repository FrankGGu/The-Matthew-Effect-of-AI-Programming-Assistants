function distinctElementSumOfSquares(nums) {
    const n = nums.length;
    let sum = 0;

    for (let i = 0; i < n; i++) {
        const seen = new Set();
        for (let j = i; j < n; j++) {
            seen.add(nums[j]);
            sum += seen.size * seen.size;
        }
    }

    return sum;
}
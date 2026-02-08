function minMoves(nums, limit) {
    const n = nums.length;
    const freq = new Array(2 * limit + 2).fill(0);

    for (let i = 0; i < n - 1; i++) {
        const a = nums[i];
        const b = nums[i + 1];
        const minVal = Math.min(a, b);
        const maxVal = Math.max(a, b);
        const low = minVal + 1;
        const high = maxVal + limit;

        freq[low]++;
        freq[high + 1]--;
    }

    let res = n - 1;
    let current = 0;

    for (let i = 2; i <= 2 * limit; i++) {
        current += freq[i];
        res = Math.min(res, current);
    }

    return res;
}
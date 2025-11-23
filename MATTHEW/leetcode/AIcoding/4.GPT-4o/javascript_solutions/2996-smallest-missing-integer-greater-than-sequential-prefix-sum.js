function smallestMissingInteger(nums) {
    const n = nums.length;
    const prefixSum = new Set();
    let sum = 0;

    for (let num of nums) {
        sum += num;
        prefixSum.add(sum);
    }

    for (let i = 1; i <= n + 1; i++) {
        if (!prefixSum.has(i)) {
            return i;
        }
    }
    return n + 1;
}
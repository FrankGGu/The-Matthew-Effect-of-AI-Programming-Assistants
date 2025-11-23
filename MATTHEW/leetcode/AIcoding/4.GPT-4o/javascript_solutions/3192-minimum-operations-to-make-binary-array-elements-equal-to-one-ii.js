function minOperations(nums) {
    const n = nums.length;
    let totalOnes = nums.reduce((acc, num) => acc + num, 0);
    let minOps = n - totalOnes;

    for (let i = 0; i < n; i++) {
        if (nums[i] === 1) {
            let count = 0;
            for (let j = 0; j < n; j++) {
                if (nums[(i + j) % n] === 0) count++;
            }
            minOps = Math.min(minOps, count);
        }
    }

    return minOps;
}
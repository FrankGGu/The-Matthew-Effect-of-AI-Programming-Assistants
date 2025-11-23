var maxScore = function(nums, x) {
    const n = nums.length;
    let even = nums[0] % 2 === 0 ? nums[0] : -Infinity;
    let odd = nums[0] % 2 !== 0 ? nums[0] : -Infinity;

    for (let i = 1; i < n; i++) {
        const num = nums[i];
        if (num % 2 === 0) {
            even = Math.max(even + num, odd + num - x);
        } else {
            odd = Math.max(odd + num, even + num - x);
        }
    }

    return Math.max(even, odd);
};
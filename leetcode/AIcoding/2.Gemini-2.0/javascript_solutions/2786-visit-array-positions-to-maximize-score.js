var maxScore = function(nums, x) {
    const n = nums.length;
    let even = nums[0] % 2 === 0 ? nums[0] : -Infinity;
    let odd = nums[0] % 2 !== 0 ? nums[0] : -Infinity;

    for (let i = 1; i < n; i++) {
        const num = nums[i];
        const isEven = num % 2 === 0;

        let newEven = even;
        let newOdd = odd;

        if (isEven) {
            newEven = Math.max(even + num, odd + num - x);
        } else {
            newOdd = Math.max(odd + num, even + num - x);
        }

        even = newEven;
        odd = newOdd;
    }

    return Math.max(even, odd);
};
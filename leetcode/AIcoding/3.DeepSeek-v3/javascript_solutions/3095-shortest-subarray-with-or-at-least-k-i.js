var shortestSubarray = function(nums, k) {
    let minLength = Infinity;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        let currentOr = 0;
        for (let j = i; j < n; j++) {
            currentOr |= nums[j];
            if (currentOr >= k) {
                minLength = Math.min(minLength, j - i + 1);
                break;
            }
        }
    }

    return minLength === Infinity ? -1 : minLength;
};
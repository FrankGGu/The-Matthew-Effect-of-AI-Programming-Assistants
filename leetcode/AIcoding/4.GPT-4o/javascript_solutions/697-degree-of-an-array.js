var findShortestSubarray = function(nums) {
    const count = new Map();
    let degree = 0;
    for (let i = 0; i < nums.length; i++) {
        count.set(nums[i], (count.get(nums[i]) || 0) + 1);
        degree = Math.max(degree, count.get(nums[i]));
    }

    const first = new Map();
    const last = new Map();
    for (let i = 0; i < nums.length; i++) {
        if (!first.has(nums[i])) first.set(nums[i], i);
        last.set(nums[i], i);
    }

    let minLength = Infinity;
    for (let [num, cnt] of count) {
        if (cnt === degree) {
            minLength = Math.min(minLength, last.get(num) - first.get(num) + 1);
        }
    }

    return minLength;
};
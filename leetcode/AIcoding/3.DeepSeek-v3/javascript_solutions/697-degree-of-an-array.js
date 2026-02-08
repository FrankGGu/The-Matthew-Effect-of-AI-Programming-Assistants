var findShortestSubArray = function(nums) {
    const count = {};
    const first = {};
    const last = {};
    let maxDegree = 0;

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        if (count[num] === undefined) {
            count[num] = 1;
            first[num] = i;
            last[num] = i;
        } else {
            count[num]++;
            last[num] = i;
        }
        maxDegree = Math.max(maxDegree, count[num]);
    }

    let minLength = Infinity;
    for (const num in count) {
        if (count[num] === maxDegree) {
            minLength = Math.min(minLength, last[num] - first[num] + 1);
        }
    }

    return minLength;
};
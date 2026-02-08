var minimumSeconds = function(nums) {
    const n = nums.length;
    const pos = {};
    for (let i = 0; i < n; i++) {
        if (!pos[nums[i]]) {
            pos[nums[i]] = [];
        }
        pos[nums[i]].push(i);
    }

    let ans = Infinity;
    for (const num in pos) {
        const arr = pos[num];
        let maxDiff = 0;
        for (let i = 0; i < arr.length; i++) {
            let diff;
            if (i === arr.length - 1) {
                diff = arr[0] + n - arr[i];
            } else {
                diff = arr[i + 1] - arr[i];
            }
            maxDiff = Math.max(maxDiff, diff);
        }
        ans = Math.min(ans, Math.floor(maxDiff / 2));
    }

    return ans;
};
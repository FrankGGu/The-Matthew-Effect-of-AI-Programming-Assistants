var smallestSubarrays = function(nums) {
    const n = nums.length;
    const ans = new Array(n).fill(1);
    const last = new Array(32).fill(-1);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < 32; j++) {
            if ((nums[i] >> j) & 1) {
                last[j] = i;
            }
        }

        let mx = -1;
        for (let j = 0; j < 32; j++) {
            mx = Math.max(mx, last[j]);
        }

        if (mx !== -1) {
            ans[i] = mx - i + 1;
        }
    }

    return ans;
};
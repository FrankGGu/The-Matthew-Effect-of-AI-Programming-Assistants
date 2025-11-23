var smallestSubarrays = function(nums) {
    const n = nums.length;
    const ans = new Array(n);
    const lastBitIndex = new Array(30).fill(-1); 

    for (let i = n - 1; i >= 0; i--) {
        let maxJ = i; 

        for (let k = 0; k < 30; k++) {
            if ((nums[i] >> k) & 1) {
                lastBitIndex[k] = i;
            }

            if (lastBitIndex[k] !== -1) {
                maxJ = Math.max(maxJ, lastBitIndex[k]);
            }
        }
        ans[i] = maxJ - i + 1;
    }

    return ans;
};
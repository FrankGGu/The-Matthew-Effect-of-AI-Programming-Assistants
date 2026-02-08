var minKBitFlips = function(nums, k) {
    const n = nums.length;
    let flip = 0;
    let res = 0;
    const isFlipped = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        if (i >= k) {
            flip ^= isFlipped[i - k];
        }
        if ((nums[i] ^ flip) === 0) {
            if (i + k > n) {
                return -1;
            }
            flip ^= 1;
            isFlipped[i] = 1;
            res++;
        }
    }
    return res;
};
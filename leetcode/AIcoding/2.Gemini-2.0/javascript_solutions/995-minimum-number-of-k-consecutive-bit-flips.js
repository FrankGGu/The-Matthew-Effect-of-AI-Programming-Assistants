var minKBitFlips = function(nums, k) {
    let n = nums.length;
    let flips = 0;
    let flipped = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        if (flipped[i] % 2 === 0 && nums[i] === 0) {
            flips++;
            if (i + k > n) {
                return -1;
            }
            for (let j = i; j < i + k; j++) {
                flipped[j]++;
            }
        } else if (flipped[i] % 2 !== 0 && nums[i] === 1) {
            flips++;
            if (i + k > n) {
                return -1;
            }
            for (let j = i; j < i + k; j++) {
                flipped[j]++;
            }
        }
    }

    return flips;
};
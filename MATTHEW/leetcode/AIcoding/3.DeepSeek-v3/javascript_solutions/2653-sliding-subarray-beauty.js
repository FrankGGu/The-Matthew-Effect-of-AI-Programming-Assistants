var getSubarrayBeauty = function(nums, k, x) {
    const n = nums.length;
    const result = [];
    const freq = new Array(51).fill(0);

    for (let i = 0; i < n; i++) {
        const num = nums[i];
        if (num < 0) {
            freq[Math.abs(num)]++;
        }

        if (i >= k - 1) {
            let count = 0;
            let beauty = 0;
            for (let j = 50; j >= 1; j--) {
                count += freq[j];
                if (count >= x) {
                    beauty = -j;
                    break;
                }
            }
            result.push(beauty);

            const leftNum = nums[i - k + 1];
            if (leftNum < 0) {
                freq[Math.abs(leftNum)]--;
            }
        }
    }

    return result;
};
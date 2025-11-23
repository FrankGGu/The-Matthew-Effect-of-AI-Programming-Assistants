function beautifulIndices(nums, k) {
    const result = [];
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        let isBeautiful = true;
        for (let j = 0; j < n; j++) {
            if (i !== j && Math.abs(i - j) <= k && nums[i] === nums[j]) {
                isBeautiful = false;
                break;
            }
        }
        if (isBeautiful) {
            result.push(i);
        }
    }
    return result;
}
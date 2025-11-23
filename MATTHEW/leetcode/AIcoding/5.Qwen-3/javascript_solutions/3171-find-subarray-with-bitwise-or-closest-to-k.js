function closestToK(nums, k) {
    let minDiff = Infinity;
    let result = 0;
    for (let i = 0; i < nums.length; i++) {
        let currentOr = 0;
        for (let j = i; j < nums.length; j++) {
            currentOr |= nums[j];
            let diff = Math.abs(currentOr - k);
            if (diff < minDiff) {
                minDiff = diff;
                result = currentOr;
            }
        }
    }
    return result;
}
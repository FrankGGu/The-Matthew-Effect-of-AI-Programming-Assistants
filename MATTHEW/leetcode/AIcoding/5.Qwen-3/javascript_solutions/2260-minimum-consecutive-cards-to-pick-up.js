function minimumCardPick(nums) {
    const map = new Map();
    let minLen = Infinity;

    for (let i = 0; i < nums.length; i++) {
        if (map.has(nums[i])) {
            minLen = Math.min(minLen, i - map.get(nums[i]) + 1);
        }
        map.set(nums[i], i);
    }

    return minLen === Infinity ? -1 : minLen;
}
function minSubarray(nums, p) {
    const mod = nums.reduce((sum, num) => (sum + num) % p, 0);
    if (mod === 0) return 0;

    const map = new Map();
    map.set(0, -1);
    let prefixMod = 0;
    let minLen = Infinity;

    for (let i = 0; i < nums.length; i++) {
        prefixMod = (prefixMod + nums[i]) % p;
        const target = (prefixMod - mod + p) % p;
        if (map.has(target)) {
            minLen = Math.min(minLen, i - map.get(target));
        }
        map.set(prefixMod, i);
    }

    return minLen === Infinity ? -1 : minLen;
}
function checkSubarraySum(nums) {
    const prefixMod = new Map();
    prefixMod.set(0, -1);
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
        const mod = sum % 2;
        if (prefixMod.has(mod)) {
            const prev = prefixMod.get(mod);
            if (i - prev >= 2) {
                return true;
            }
        } else {
            prefixMod.set(mod, i);
        }
    }
    return false;
}
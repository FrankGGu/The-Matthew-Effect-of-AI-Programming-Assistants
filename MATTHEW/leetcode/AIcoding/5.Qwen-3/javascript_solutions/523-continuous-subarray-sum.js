function continuousSubarraySum(nums, k) {
    const map = new Map();
    map.set(0, -1);
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
        const mod = sum % k;
        if (map.has(mod)) {
            if (i - map.get(mod) >= 2) {
                return true;
            }
        } else {
            map.set(mod, i);
        }
    }
    return false;
}
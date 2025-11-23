var checkSubarraySum = function(nums, k) {
    const map = new Map();
    map.set(0, -1);
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
        const remainder = sum % k;
        if (map.has(remainder)) {
            if (i - map.get(remainder) >= 2) {
                return true;
            }
        } else {
            map.set(remainder, i);
        }
    }
    return false;
};
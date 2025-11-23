var countGoodSubarrays = function(nums, k) {
    let count = 0;
    let left = 0;
    let map = new Map();
    let pairs = 0;

    for (let right = 0; right < nums.length; right++) {
        if (map.has(nums[right])) {
            pairs += map.get(nums[right]);
            map.set(nums[right], map.get(nums[right]) + 1);
        } else {
            map.set(nums[right], 1);
        }

        while (pairs >= k) {
            count += nums.length - right;
            if (map.get(nums[left]) > 1) {
                pairs -= map.get(nums[left]) - 1;
                map.set(nums[left], map.get(nums[left]) - 1);
            } else {
                map.delete(nums[left]);
            }
            left++;
        }
    }

    return count;
};
var minOperations = function(nums, k) {
    let sum = 0;
    for (let num of nums) {
        sum = (sum + num) % k;
    }

    if (sum === 0) {
        return 0;
    }

    let n = nums.length;
    let prefixSum = 0;
    let map = new Map();
    map.set(0, -1);
    let ans = Infinity;

    for (let i = 0; i < n; i++) {
        prefixSum = (prefixSum + nums[i]) % k;
        let target = (prefixSum - sum + k) % k;

        if (map.has(target)) {
            ans = Math.min(ans, i - map.get(target));
        }

        map.set(prefixSum, i);
    }

    return ans === Infinity ? -1 : ans;
};
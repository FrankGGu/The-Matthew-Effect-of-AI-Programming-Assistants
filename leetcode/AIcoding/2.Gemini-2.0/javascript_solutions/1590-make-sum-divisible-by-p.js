var minSubarray = function(nums, p) {
    let n = nums.length;
    let totalSum = 0;
    for (let num of nums) {
        totalSum = (totalSum + num) % p;
    }

    if (totalSum === 0) {
        return 0;
    }

    let minLen = n;
    let prefixSum = 0;
    let map = new Map();
    map.set(0, -1);

    for (let i = 0; i < n; i++) {
        prefixSum = (prefixSum + nums[i]) % p;
        let target = (prefixSum - totalSum + p) % p;

        if (map.has(target)) {
            minLen = Math.min(minLen, i - map.get(target));
        }
        map.set(prefixSum, i);
    }

    return minLen === n ? -1 : minLen;
};
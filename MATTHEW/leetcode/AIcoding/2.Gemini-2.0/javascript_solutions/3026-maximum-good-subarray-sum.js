var maximumGoodSubarraySum = function(nums, k) {
    let map = new Map();
    let sum = 0;
    let ans = -Infinity;
    map.set(0, -1);

    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];

        for (let j = 0; j < nums.length; j++) {
            if (Math.abs(nums[i] - nums[j]) === k) {
                if (map.has(i)) {
                    continue;
                }

                let currentSum = sum;
                let prefixSum = 0;
                for (let l = 0; l <= j -1; l++) {
                    prefixSum += nums[l];
                }

                ans = Math.max(ans, currentSum - prefixSum);
            }
        }

        map.set(i, sum);
    }

    if(ans === -Infinity) return -1;
    return ans;
};
var maximumSubarraySum = function(nums, x) {
    let n = nums.length;
    let ans = -Infinity;
    for (let i = 0; i < n; i++) {
        let current = 0;
        for (let j = i; j < n; j++) {
            if (nums[j] !== x) {
                current += nums[j];
                ans = Math.max(ans, current);
            } else {
                current = 0;
            }
        }
    }

    if (ans === -Infinity) return -1;

    let totalSum = 0;
    let containsNonX = false;
    for(let num of nums){
        if(num !== x){
            totalSum += num;
            containsNonX = true;
        }
    }

    if(!containsNonX) return -1;

    return ans;
};
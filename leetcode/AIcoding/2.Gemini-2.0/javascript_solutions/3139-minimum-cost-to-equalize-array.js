var minCost = function(nums, cost) {
    let l = Math.min(...nums);
    let r = Math.max(...nums);
    let ans = Infinity;

    while (l <= r) {
        let mid = Math.floor((l + r) / 2);
        let cost1 = 0;
        let cost2 = 0;
        for (let i = 0; i < nums.length; i++) {
            cost1 += Math.abs(nums[i] - mid) * cost[i];
            cost2 += Math.abs(nums[i] - (mid + 1)) * cost[i];
        }

        ans = Math.min(ans, cost1, cost2);

        if (cost1 < cost2) {
            r = mid - 1;
        } else {
            l = mid + 1;
        }
    }

    return ans;
};
var divideArray = function(nums, k, dist) {
    let n = nums.length;
    let ans = Infinity;

    for (let i = 0; i <= n - 2 * k - dist; i++) {
        let cost = nums[i];
        let arr = [];
        for (let j = i + 1; j < n; j++) {
            arr.push(nums[j]);
        }

        arr.sort((a, b) => a - b);

        let currentCost = cost;
        for (let j = 0; j < k - 1; j++) {
            currentCost += arr[j];
        }

        ans = Math.min(ans, currentCost);
    }

    return ans;
};
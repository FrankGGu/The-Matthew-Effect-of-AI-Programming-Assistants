var minAbsoluteDifference = function(nums, x) {
    let n = nums.length;
    let set = new Set();
    let ans = Infinity;
    for (let i = x; i < n; i++) {
        set.add(nums[i - x]);
        let arr = Array.from(set).sort((a, b) => a - b);
        let l = 0, r = arr.length - 1;
        while (l <= r) {
            let mid = Math.floor((l + r) / 2);
            ans = Math.min(ans, Math.abs(nums[i] - arr[mid]));
            if (arr[mid] < nums[i]) {
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }
    }
    return ans === Infinity ? -1 : ans;
};
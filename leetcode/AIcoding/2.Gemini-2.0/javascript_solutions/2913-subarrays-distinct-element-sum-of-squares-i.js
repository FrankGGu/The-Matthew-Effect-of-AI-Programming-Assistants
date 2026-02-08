var sumCounts = function(nums) {
    let n = nums.length;
    let ans = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            let subarray = nums.slice(i, j + 1);
            let distinct = new Set(subarray).size;
            ans += distinct * distinct;
        }
    }
    return ans;
};
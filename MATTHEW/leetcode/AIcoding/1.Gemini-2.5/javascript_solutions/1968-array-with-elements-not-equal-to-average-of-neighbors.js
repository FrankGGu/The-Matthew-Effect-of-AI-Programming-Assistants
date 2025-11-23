var rearrangeArray = function(nums) {
    nums.sort((a, b) => a - b);

    const n = nums.length;
    const result = new Array(n);

    let p = 0;
    // Fill even indices with smaller elements
    for (let i = 0; i < n; i += 2) {
        result[i] = nums[p++];
    }

    // Fill odd indices with remaining larger elements
    for (let i = 1; i < n; i += 2) {
        result[i] = nums[p++];
    }

    return result;
};
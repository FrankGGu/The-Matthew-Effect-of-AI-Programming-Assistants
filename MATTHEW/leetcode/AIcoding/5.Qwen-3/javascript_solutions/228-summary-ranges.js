function summaryRanges(nums) {
    const result = [];
    let start = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] !== nums[i - 1] + 1) {
            if (start === i - 1) {
                result.push(nums[start].toString());
            } else {
                result.push(nums[start] + "->" + nums[i - 1]);
            }
            start = i;
        }
    }
    if (start < nums.length) {
        if (start === nums.length - 1) {
            result.push(nums[start].toString());
        } else {
            result.push(nums[start] + "->" + nums[nums.length - 1]);
        }
    }
    return result;
}
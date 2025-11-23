var rearrangeArray = function(nums) {
    const n = nums.length;
    const result = new Array(n);
    let posIndex = 0;
    let negIndex = 1;

    for (let i = 0; i < n; i++) {
        if (nums[i] > 0) {
            result[posIndex] = nums[i];
            posIndex += 2;
        } else {
            result[negIndex] = nums[i];
            negIndex += 2;
        }
    }

    return result;
};
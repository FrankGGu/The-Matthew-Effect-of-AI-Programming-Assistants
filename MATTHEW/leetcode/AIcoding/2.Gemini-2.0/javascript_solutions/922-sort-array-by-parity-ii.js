var sortArrayByParityII = function(nums) {
    let evenIndex = 0;
    let oddIndex = 1;

    while (evenIndex < nums.length && oddIndex < nums.length) {
        if (nums[evenIndex] % 2 !== 0) {
            if (nums[oddIndex] % 2 === 0) {
                [nums[evenIndex], nums[oddIndex]] = [nums[oddIndex], nums[evenIndex]];
                evenIndex += 2;
                oddIndex += 2;
            } else {
                oddIndex += 2;
            }
        } else {
            evenIndex += 2;
        }
    }
    return nums;
};
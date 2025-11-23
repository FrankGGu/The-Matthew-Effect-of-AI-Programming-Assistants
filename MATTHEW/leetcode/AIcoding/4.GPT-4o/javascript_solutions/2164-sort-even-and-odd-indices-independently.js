var sortEvenOdd = function(nums) {
    const evenIndices = [];
    const oddIndices = [];

    for (let i = 0; i < nums.length; i++) {
        if (i % 2 === 0) {
            evenIndices.push(nums[i]);
        } else {
            oddIndices.push(nums[i]);
        }
    }

    evenIndices.sort((a, b) => a - b);
    oddIndices.sort((a, b) => b - a);

    for (let i = 0; i < nums.length; i++) {
        nums[i] = (i % 2 === 0) ? evenIndices[i / 2 | 0] : oddIndices[i / 2 | 0];
    }

    return nums;
};
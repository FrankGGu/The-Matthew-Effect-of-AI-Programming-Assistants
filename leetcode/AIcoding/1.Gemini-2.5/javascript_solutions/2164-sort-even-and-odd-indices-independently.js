var sortEvenAndOdd = function(nums) {
    const n = nums.length;
    if (n <= 1) {
        return nums;
    }

    const evenIndices = [];
    const oddIndices = [];

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            evenIndices.push(nums[i]);
        } else {
            oddIndices.push(nums[i]);
        }
    }

    evenIndices.sort((a, b) => a - b);
    oddIndices.sort((a, b) => b - a);

    const result = new Array(n);
    let evenPtr = 0;
    let oddPtr = 0;

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            result[i] = evenIndices[evenPtr++];
        } else {
            result[i] = oddIndices[oddPtr++];
        }
    }

    return result;
};
var sortedSquares = function(nums) {
    const n = nums.length;
    const result = new Array(n);
    let left = 0;
    let right = n - 1;
    let p = n - 1;

    while (left <= right) {
        const leftSquare = nums[left] * nums[left];
        const rightSquare = nums[right] * nums[right];

        if (leftSquare > rightSquare) {
            result[p] = leftSquare;
            left++;
        } else {
            result[p] = rightSquare;
            right--;
        }
        p--;
    }

    return result;
};
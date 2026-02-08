function separateSquares(nums) {
    let result = [];
    let j = 0;

    for (let i = 0; i < nums.length; i++) {
        if (Math.sqrt(nums[i]) % 1 === 0) {
            result[j++] = nums[i];
        }
    }

    for (let i = 0; i < nums.length; i++) {
        if (Math.sqrt(nums[i]) % 1 !== 0) {
            result[j++] = nums[i];
        }
    }

    return result;
}
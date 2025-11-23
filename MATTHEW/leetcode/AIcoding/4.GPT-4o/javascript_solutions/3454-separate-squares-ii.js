function separateSquares(nums) {
    const result = [];
    let left = 0, right = nums.length - 1;

    while (left <= right) {
        if (nums[left] < 0) {
            result.push(nums[left]);
            left++;
        } else if (nums[right] >= 0) {
            result.unshift(nums[right]);
            right--;
        } else {
            left++;
            right--;
        }
    }

    return result;
}
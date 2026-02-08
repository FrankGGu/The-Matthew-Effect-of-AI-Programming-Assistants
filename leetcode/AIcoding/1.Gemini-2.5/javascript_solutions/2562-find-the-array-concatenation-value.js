var findTheArrayConcatenationValue = function(nums) {
    let concatenationValue = 0;
    let left = 0;
    let right = nums.length - 1;

    while (left <= right) {
        if (left === right) {
            concatenationValue += nums[left];
        } else {
            const concatenatedNumStr = String(nums[left]) + String(nums[right]);
            concatenationValue += parseInt(concatenatedNumStr);
        }
        left++;
        right--;
    }

    return concatenationValue;
};
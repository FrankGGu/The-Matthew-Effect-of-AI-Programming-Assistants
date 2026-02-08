var maxSum = function(nums) {
    let max_sum = -1;
    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            if (getMaxDigit(nums[i]) === getMaxDigit(nums[j])) {
                max_sum = Math.max(max_sum, nums[i] + nums[j]);
            }
        }
    }
    return max_sum;

    function getMaxDigit(num) {
        let max_digit = 0;
        let str_num = num.toString();
        for (let i = 0; i < str_num.length; i++) {
            max_digit = Math.max(max_digit, parseInt(str_num[i]));
        }
        return max_digit;
    }
};
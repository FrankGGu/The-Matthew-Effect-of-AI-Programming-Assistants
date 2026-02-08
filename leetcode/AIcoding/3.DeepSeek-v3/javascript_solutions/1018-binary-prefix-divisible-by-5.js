var prefixesDivBy5 = function(nums) {
    let result = [];
    let num = 0;
    for (let i = 0; i < nums.length; i++) {
        num = (num * 2 + nums[i]) % 5;
        result.push(num === 0);
    }
    return result;
};
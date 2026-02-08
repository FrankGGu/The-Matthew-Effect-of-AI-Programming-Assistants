var smallestEqual = function(nums) {
    for (let i = 0; i < nums.length; i++) {
        let sum = 0;
        let numStr = String(i);
        for (let j = 0; j < numStr.length; j++) {
            sum += parseInt(numStr[j]);
        }
        if (sum % 10 === nums[i]) {
            return i;
        }
    }
    return -1;
};
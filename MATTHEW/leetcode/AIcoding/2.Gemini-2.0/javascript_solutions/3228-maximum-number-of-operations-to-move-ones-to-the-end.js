var maximumNumberOfOnes = function(nums) {
    let ones = nums.filter(num => num === 1).length;
    let operations = 0;
    let i = 0;
    while (i < nums.length && nums[i] === 1) {
        i++;
    }
    let j = nums.length - 1;
    while (j >= 0 && nums[j] === 1) {
        j--;
    }

    while (i < j) {
        if (nums[i] === 0 && nums[j] === 0) {
            i++;
            j--;
        } else if (nums[i] === 1 && nums[j] === 0) {
            operations++;
            i++;
            j--;
        } else if (nums[i] === 0 && nums[j] === 1) {
            i++;
            j--;
        } else {
            i++;
        }
    }

    return operations;
};
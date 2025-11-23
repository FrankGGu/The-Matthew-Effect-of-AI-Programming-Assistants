var findTheNumberCopyArrays = function(nums) {
    const n = nums.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        let isCopy = true;
        for (let j = 0; j < n; j++) {
            if (i !== j) {
                if (nums[i].length !== nums[j].length) {
                    continue;
                }
                let isEqual = true;
                for (let k = 0; k < nums[i].length; k++) {
                    if (nums[i][k] !== nums[j][k]) {
                        isEqual = false;
                        break;
                    }
                }
                if (isEqual) {
                    isCopy = false;
                    break;
                }
            }
        }
        if (isCopy) {
            count++;
        }
    }
    return count;
};
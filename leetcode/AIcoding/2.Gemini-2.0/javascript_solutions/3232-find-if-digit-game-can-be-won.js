var digitGame = function(nums, k) {
    if (nums.length % 2 !== 0 && k > 1) {
        return true;
    }
    if (nums.length % 2 === 0 && k > 1) {
        return false;
    }
    if (nums.length % 2 !== 0) {
        let sumOdd = 0;
        let sumEven = 0;
        for (let i = 0; i < nums.length; i++) {
            if (i % 2 === 0) {
                sumEven += parseInt(nums[i]);
            } else {
                sumOdd += parseInt(nums[i]);
            }
        }
        return sumEven >= sumOdd;
    } else {
        let sumOdd = 0;
        let sumEven = 0;
        for (let i = 0; i < nums.length; i++) {
            if (i % 2 === 0) {
                sumEven += parseInt(nums[i]);
            } else {
                sumOdd += parseInt(nums[i]);
            }
        }
        return sumEven > sumOdd;
    }
};
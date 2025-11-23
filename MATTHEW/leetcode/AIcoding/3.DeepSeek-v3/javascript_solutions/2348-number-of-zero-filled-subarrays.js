var zeroFilledSubarray = function(nums) {
    let res = 0;
    let current = 0;

    for (const num of nums) {
        if (num === 0) {
            current++;
            res += current;
        } else {
            current = 0;
        }
    }

    return res;
};
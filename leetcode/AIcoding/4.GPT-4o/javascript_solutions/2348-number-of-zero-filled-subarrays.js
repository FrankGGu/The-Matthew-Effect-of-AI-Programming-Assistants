var zeroFilledSubarray = function(nums) {
    let count = 0, zeroCount = 0;
    for (let num of nums) {
        if (num === 0) {
            zeroCount++;
            count += zeroCount;
        } else {
            zeroCount = 0;
        }
    }
    return count;
};
var maximizeSum = function(nums, k) {
    let ones = 0;
    let zeros = 0;
    let negOnes = 0;

    for (let num of nums) {
        if (num === 1) {
            ones++;
        } else if (num === 0) {
            zeros++;
        } else {
            negOnes++;
        }
    }

    if (k <= ones) {
        return k;
    } else if (k <= ones + zeros) {
        return ones;
    } else {
        return ones - (k - ones - zeros);
    }
};
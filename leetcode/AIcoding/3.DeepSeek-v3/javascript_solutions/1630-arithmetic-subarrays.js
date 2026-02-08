var checkArithmeticSubarrays = function(nums, l, r) {
    const result = [];
    for (let i = 0; i < l.length; i++) {
        const subarray = nums.slice(l[i], r[i] + 1);
        subarray.sort((a, b) => a - b);
        let isArithmetic = true;
        const diff = subarray[1] - subarray[0];
        for (let j = 2; j < subarray.length; j++) {
            if (subarray[j] - subarray[j - 1] !== diff) {
                isArithmetic = false;
                break;
            }
        }
        result.push(isArithmetic);
    }
    return result;
};
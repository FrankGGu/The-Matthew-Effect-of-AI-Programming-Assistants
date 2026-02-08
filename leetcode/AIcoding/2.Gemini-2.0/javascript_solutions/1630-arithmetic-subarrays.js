var checkArithmeticSubarrays = function(nums, l, r) {
    const result = [];
    for (let i = 0; i < l.length; i++) {
        const start = l[i];
        const end = r[i];
        const subarray = nums.slice(start, end + 1).sort((a, b) => a - b);
        if (subarray.length < 2) {
            result.push(true);
            continue;
        }
        const diff = subarray[1] - subarray[0];
        let isArithmetic = true;
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
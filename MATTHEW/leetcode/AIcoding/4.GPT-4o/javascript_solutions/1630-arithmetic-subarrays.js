var checkArithmeticSubarrays = function(nums, l, r) {
    const results = [];

    for (let i = 0; i < l.length; i++) {
        const start = l[i];
        const end = r[i];
        const subarray = nums.slice(start, end + 1);
        subarray.sort((a, b) => a - b);

        let isArithmetic = true;
        const diff = subarray[1] - subarray[0];

        for (let j = 2; j < subarray.length; j++) {
            if (subarray[j] - subarray[j - 1] !== diff) {
                isArithmetic = false;
                break;
            }
        }

        results.push(isArithmetic);
    }

    return results;
};
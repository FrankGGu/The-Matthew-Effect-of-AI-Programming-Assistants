function checkArithmeticSubarrays(nums, l, r) {
    const result = [];

    for (let i = 0; i < l.length; i++) {
        const left = l[i];
        const right = r[i];
        const subarray = nums.slice(left, right + 1);
        const sorted = [...subarray].sort((a, b) => a - b);
        const diff = sorted[1] - sorted[0];
        let isArithmetic = true;

        for (let j = 2; j < sorted.length; j++) {
            if (sorted[j] - sorted[j - 1] !== diff) {
                isArithmetic = false;
                break;
            }
        }

        result.push(isArithmetic);
    }

    return result;
}
var getSubarrayBeauty = function(nums, k, x) {
    const n = nums.length;
    const result = [];
    for (let i = 0; i <= n - k; i++) {
        const subarray = nums.slice(i, i + k);
        const negativeNumbers = subarray.filter(num => num < 0);
        negativeNumbers.sort((a, b) => a - b);
        if (negativeNumbers.length >= x) {
            result.push(negativeNumbers[x - 1]);
        } else {
            result.push(0);
        }
    }
    return result;
};
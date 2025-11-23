var maxStrength = function(nums, k) {
    const n = nums.length;
    let dp = Array(n + 1).fill(0);
    let prefixProduct = 1;
    let negativeCount = 0;
    let zeroCount = 0;

    for (let num of nums) {
        if (num < 0) negativeCount++;
        if (num === 0) zeroCount++;
        prefixProduct *= num === 0 ? 1 : num;
    }

    if (negativeCount % 2 === 0 || zeroCount > 0) {
        return prefixProduct;
    }

    let minNegative = Number.MAX_VALUE;
    for (let num of nums) {
        if (num < 0) {
            minNegative = Math.min(minNegative, num);
        }
    }

    return prefixProduct / minNegative;
};
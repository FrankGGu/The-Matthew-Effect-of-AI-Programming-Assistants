var numOfWays = function (nums) {
    const n = nums.length;
    const mod = 1e9 + 7;

    const count = new Map();
    for (const num of nums) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    let result = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const product = nums[i] * nums[j];
            const sqrt = Math.sqrt(product);
            if (Number.isInteger(sqrt) && count.has(sqrt)) {
                result = (result + count.get(sqrt)) % mod;
            }
        }
    }

    return result;
};
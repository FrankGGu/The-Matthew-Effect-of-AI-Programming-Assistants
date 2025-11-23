var tupleSameProduct = function(nums) {
    const productCount = {};
    let count = 0;

    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            const product = nums[i] * nums[j];
            productCount[product] = (productCount[product] || 0) + 1;
        }
    }

    for (const key in productCount) {
        const n = productCount[key];
        if (n > 1) {
            count += n * (n - 1) / 2 * 8; // each pair can form 8 tuples
        }
    }

    return count;
};
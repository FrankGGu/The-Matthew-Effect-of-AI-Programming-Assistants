var maxEqualProduct = function(nums) {
    const productCount = new Map();
    let maxLength = 0;

    for (let i = 0; i < nums.length; i++) {
        let product = 1;
        for (let j = i; j < nums.length; j++) {
            product *= nums[j];
            if (!productCount.has(product)) {
                productCount.set(product, j - i + 1);
            } else {
                productCount.set(product, Math.max(productCount.get(product), j - i + 1));
            }
            maxLength = Math.max(maxLength, productCount.get(product));
        }
    }

    return maxLength;
};
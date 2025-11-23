var maxSubarrayLength = function(nums) {
    let maxLen = 0;
    let prefixProduct = 1;
    let prefixProducts = new Map();
    prefixProducts.set(1, -1);

    for (let i = 0; i < nums.length; i++) {
        prefixProduct *= nums[i];

        if (prefixProducts.has(prefixProduct)) {
            maxLen = Math.max(maxLen, i - prefixProducts.get(prefixProduct));
        } else {
            prefixProducts.set(prefixProduct, i);
        }
    }

    return maxLen;
};
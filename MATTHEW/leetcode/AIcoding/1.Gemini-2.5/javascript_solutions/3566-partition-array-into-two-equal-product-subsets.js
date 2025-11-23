var productSubsets = function(nums) {
    const n = nums.length;

    if (n < 2) {
        return false;
    }

    let zeroCount = 0;
    for (let i = 0; i < n; i++) {
        if (nums[i] === 0) {
            zeroCount++;
        }
    }

    if (zeroCount === 1) {
        return false;
    }

    if (zeroCount >= 2) {
        let currentZerosLeft = 0;
        let currentZerosRight = zeroCount;

        for (let i = 0; i < n - 1; i++) {
            if (nums[i] === 0) {
                currentZerosLeft++;
                currentZerosRight--;
            }
            if (currentZerosLeft >= 1 && currentZerosRight >= 1) {
                return true;
            }
        }
        return false;
    }

    // Case: zeroCount === 0 (no zeros in the array)
    // Use BigInt to handle potentially very large products.
    let totalProduct = 1n;
    for (let i = 0; i < n; i++) {
        totalProduct *= BigInt(nums[i]);
    }

    let leftProduct = 1n;
    for (let i = 0; i < n - 1; i++) {
        leftProduct *= BigInt(nums[i]);
        // leftProduct is the product of nums[0]...nums[i].
        // The rightProduct would be totalProduct / leftProduct.
        // We are looking for leftProduct === rightProduct.
        // This implies leftProduct === totalProduct / leftProduct,
        // which simplifies to leftProduct * leftProduct === totalProduct.
        if (leftProduct * leftProduct === totalProduct) {
            return true;
        }
    }

    return false;
};
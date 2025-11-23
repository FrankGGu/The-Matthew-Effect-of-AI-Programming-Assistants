var numTriplets = function(nums1, nums2) {
    const countPairs = (arr1, arr2) => {
        const prodMap = new Map();
        for (let j = 0; j < arr2.length; j++) {
            for (let k = j + 1; k < arr2.length; k++) {
                const product = arr2[j] * arr2[k];
                prodMap.set(product, (prodMap.get(product) || 0) + 1);
            }
        }

        let count = 0;
        for (let i = 0; i < arr1.length; i++) {
            const square = arr1[i] * arr1[i];
            count += prodMap.get(square) || 0;
        }
        return count;
    };

    return countPairs(nums1, nums2) + countPairs(nums2, nums1);
};
var numTriplets = function(nums1, nums2) {
    const countTriplets = (A, B) => {
        const map = new Map();
        for (const num of B) {
            const square = num * num;
            map.set(square, (map.get(square) || 0) + 1);
        }
        let res = 0;
        for (let i = 0; i < A.length; i++) {
            for (let j = i + 1; j < A.length; j++) {
                const product = A[i] * A[j];
                res += map.get(product) || 0;
            }
        }
        return res;
    };
    return countTriplets(nums1, nums2) + countTriplets(nums2, nums1);
};
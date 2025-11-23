var minimumAddedInteger = function(nums1, nums2) {
    nums1.sort((a, b) => a - b);
    nums2.sort((a, b) => a - b);

    const n = nums1.length;
    const m = nums2.length; // m is always n - 2

    let minX = Infinity;

    // Helper function to check if a given x is valid
    // A value x is valid if nums2 can be formed by taking n-2 elements from nums1,
    // adding x to each, and then sorting.
    const isValid = (x) => {
        if (x < 0) {
            return false;
        }

        let p1 = 0; // Pointer for nums1
        let p2 = 0; // Pointer for nums2
        let removedCount = 0; // Count of elements from nums1 that are effectively "removed"

        while (p1 < n && p2 < m) {
            if (nums1[p1] + x === nums2[p2]) {
                // Match found, advance both pointers
                p1++;
                p2++;
            } else if (nums1[p1] + x < nums2[p2]) {
                // nums1[p1] + x is too small to match nums2[p2].
                // This means nums1[p1] must be one of the two elements removed from nums1.
                removedCount++;
                p1++;
            } else { // nums1[p1] + x > nums2[p2]
                // nums1[p1] + x is too large to match nums2[p2].
                // Since both arrays are sorted, no subsequent element nums1[k] (k > p1)
                // will be able to match nums2[p2] either, as nums1[k] + x will be even larger.
                // Therefore, this x is invalid.
                return false;
            }

            // If we've already removed more than 2 elements, this x is invalid.
            if (removedCount > 2) {
                return false;
            }
        }

        // If not all elements of nums2 were matched, this x is invalid.
        if (p2 < m) {
            return false;
        }

        // Count any remaining elements in nums1 (from p1 to n-1) as removed.
        // These are elements that were not matched with anything in nums2.
        removedCount += (n - p1);

        // A valid x must result in exactly 2 elements being removed from nums1.
        return removedCount === 2;
    };

    // The smallest element in nums2 (nums2[0]) must correspond to one of
    // nums1[0], nums1[1], or nums1[2] (after adding x).
    // This is because we remove exactly two elements from nums1.
    // If nums1[0] is kept, it corresponds to nums2[0]. x = nums2[0] - nums1[0].
    // If nums1[0] is removed and nums1[1] is kept, it corresponds to nums2[0]. x = nums2[0] - nums1[1].
    // If nums1[0] and nums1[1] are removed and nums1[2] is kept, it corresponds to nums2[0]. x = nums2[0] - nums1[2].
    // Any other choice for the smallest kept element in nums1 would imply removing more than 2 elements.
    const candidateXValues = [
        nums2[0] - nums1[0],
        nums2[0] - nums1[1],
        nums2[0] - nums1[2]
    ];

    for (const xCand of candidateXValues) {
        if (isValid(xCand)) {
            minX = Math.min(minX, xCand);
        }
    }

    return minX;
};
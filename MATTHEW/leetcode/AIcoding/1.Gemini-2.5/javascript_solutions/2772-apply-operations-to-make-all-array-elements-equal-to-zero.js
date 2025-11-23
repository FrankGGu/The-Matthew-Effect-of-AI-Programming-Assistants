var canMakePilesZero = function(nums, k) {
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        if (nums[i] > 0) {
            const x = nums[i]; // The amount we must subtract to make nums[i] zero.

            // Check if the operation is possible at index i.
            // The operation affects nums[i] and nums[i + k - 1].
            // So, i + k - 1 must be a valid index.
            if (i + k - 1 >= n) {
                return false; // Cannot apply operation to make nums[i] zero.
            }

            // Check non-negative constraint for nums[i + k - 1] *before* modifying it.
            // nums[i + k - 1] must be at least x to remain non-negative after subtraction.
            if (nums[i + k - 1] < x) {
                return false; // nums[i + k - 1] would become negative.
            }

            // Apply the operation:
            // Replace nums[i] with nums[i] - x
            // Replace nums[i + k - 1] with nums[i + k - 1] - x
            // These replacements are based on the values *before* the operation.
            // If i == i + k - 1 (i.e., k=1), then nums[i] is effectively reduced by x once.

            nums[i] -= x; // This makes nums[i] zero.

            // Only modify nums[i + k - 1] if it's a distinct element from nums[i].
            // If i == i + k - 1, nums[i] has already been correctly updated to 0 by the previous line.
            // Applying `nums[i + k - 1] -= x` again would make it negative.
            if (i + k - 1 !== i) {
                nums[i + k - 1] -= x;
            }
        } else if (nums[i] < 0) {
            // An element became negative, which means a previous operation violated the non-negative constraint.
            // If an element is negative, it's impossible to make it zero using only subtractions.
            return false;
        }
    }

    // If the loop completes, it means all elements were successfully made zero.
    return true;
};
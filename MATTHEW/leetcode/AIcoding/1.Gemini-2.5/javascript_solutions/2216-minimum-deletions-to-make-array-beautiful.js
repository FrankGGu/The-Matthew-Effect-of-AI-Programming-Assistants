var minDeletions = function(nums) {
    let keptCount = 0; // Represents the current length of the beautiful subsequence being built
    let deletedCount = 0; // Total deletions
    let lastKeptVal = -1; // Stores the value of the last element kept in the subsequence

    for (let i = 0; i < nums.length; i++) {
        // If keptCount is even, we are looking for the first element of a new pair (at an even index in the virtual beautiful array).
        // We always take the current element nums[i] for this position.
        if (keptCount % 2 === 0) {
            lastKeptVal = nums[i];
            keptCount++;
        } 
        // If keptCount is odd, we are looking for the second element of the current pair (at an odd index).
        // This element nums[i] must be different from the lastKeptVal.
        else {
            if (nums[i] !== lastKeptVal) {
                // If different, we keep this element, completing a valid pair.
                keptCount++;
            } else {
                // If identical, we cannot use nums[i] for this position as it violates the condition.
                // We must delete nums[i].
                deletedCount++;
            }
        }
    }

    // After iterating through all elements, if the keptCount is odd, it means the last element
    // forms an incomplete pair. To satisfy the condition that the beautiful array's length must be even,
    // we must delete this last element.
    if (keptCount % 2 !== 0) {
        deletedCount++;
    }

    return deletedCount;
};
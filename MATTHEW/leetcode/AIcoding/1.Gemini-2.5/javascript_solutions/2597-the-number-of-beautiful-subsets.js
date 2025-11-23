var beautifulSubsets = function(nums, k) {
    let count = 0;

    // Sorting nums can sometimes help with pruning or consistency,
    // though not strictly necessary for correctness with a Set for currentSubset.
    nums.sort((a, b) => a - b);

    // Use a Set to store elements in the current subset.
    // This allows O(1) average time complexity for add, delete, and has operations.
    const currentSubset = new Set();

    function backtrack(index) {
        // Base case: If all elements have been considered.
        if (index === nums.length) {
            // If the current subset is not empty, it is a beautiful subset.
            // The problem asks for non-empty beautiful subsets.
            if (currentSubset.size > 0) {
                count++;
            }
            return;
        }

        // Option 1: Exclude nums[index] from the current subset.
        // Move to the next element without adding nums[index].
        backtrack(index + 1);

        // Option 2: Include nums[index] in the current subset, if possible.
        const num = nums[index];

        // Check if including 'num' would violate the beautiful subset condition.
        // A subset is beautiful if for any two distinct elements x and y, |x - y| != k.
        // This means 'num' cannot be added if (num - k) or (num + k) is already in the current subset.
        const canInclude = !currentSubset.has(num - k) && !currentSubset.has(num + k);

        if (canInclude) {
            // Add num to the current subset.
            currentSubset.add(num);

            // Recurse to consider the next element with num included.
            backtrack(index + 1);

            // Backtrack: Remove num from the current subset to explore other possibilities.
            currentSubset.delete(num);
        }
    }

    // Start the backtracking process from the first element (index 0).
    backtrack(0);

    return count;
};
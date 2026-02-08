var recoverArray = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length / 2;

    // Helper function to try a given k
    // Returns the original array if successful, null otherwise
    const check = (currentK) => {
        const original = [];
        const counts = new Map();
        for (const num of nums) {
            counts.set(num, (counts.get(num) || 0) + 1);
        }

        for (const num of nums) {
            if (counts.get(num) > 0) {
                // Assume 'num' is original[i] - k
                const target = num + 2 * currentK;

                // Check if target exists and is available
                if (counts.has(target) && counts.get(target) > 0) {
                    original.push(num + currentK);
                    counts.set(num, counts.get(num) - 1);
                    counts.set(target, counts.get(target) - 1);
                } else {
                    // Cannot find a pair for 'num' with this k
                    return null;
                }
            }
        }

        // If we successfully formed an array of size n, it's valid
        if (original.length === n) {
            return original;
        }
        return null; 
    };

    // nums[0] must be some original[i] - k
    // We iterate through possible nums[j] that could be original[i] + k
    // This means nums[j] - nums[0] = (original[i] + k) - (original[i] - k) = 2k
    // So k = (nums[j] - nums[0]) / 2
    for (let j = 1; j < nums.length; j++) {
        const diff = nums[j] - nums[0];
        // k must be positive, so diff > 0
        // k must be an integer, so diff must be even
        if (diff > 0 && diff % 2 === 0) {
            const currentK = diff / 2;
            const result = check(currentK);
            if (result !== null) {
                return result;
            }
        }
    }

    // According to problem constraints, a solution is guaranteed to exist.
    // This line should theoretically not be reached.
    return []; 
};
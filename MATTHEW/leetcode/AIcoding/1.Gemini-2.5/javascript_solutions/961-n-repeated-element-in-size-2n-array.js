var repeatedNElement = function(nums) {
    const seen = new Set();
    for (const num of nums) {
        if (seen.has(num)) {
            return num;
        }
        seen.add(num);
    }
    // This line should not be reached based on the problem description
    // which guarantees that exactly one element is repeated N times.
    return -1; 
};
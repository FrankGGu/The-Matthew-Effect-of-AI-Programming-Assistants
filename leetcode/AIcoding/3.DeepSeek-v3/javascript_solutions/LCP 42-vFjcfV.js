var numberOfPoints = function(nums) {
    const covered = new Set();
    for (const [start, end] of nums) {
        for (let i = start; i <= end; i++) {
            covered.add(i);
        }
    }
    return covered.size;
};
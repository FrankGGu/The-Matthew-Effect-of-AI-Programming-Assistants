var maxNonOverlapping = function(nums, target) {
    let count = 0;
    let currentSum = 0;
    let prefixSums = new Set();
    prefixSums.add(0);

    for (let num of nums) {
        currentSum += num;
        if (prefixSums.has(currentSum - target)) {
            count++;
            currentSum = 0;
            prefixSums.clear();
            prefixSums.add(0);
        } else {
            prefixSums.add(currentSum);
        }
    }

    return count;
};
var maxNonOverlapping = function(nums, target) {
    let prefixSum = 0;
    let seen = new Set([0]);
    let count = 0;

    for (let num of nums) {
        prefixSum += num;
        if (seen.has(prefixSum - target)) {
            count++;
            seen = new Set();
            prefixSum = 0;
        }
        seen.add(prefixSum);
    }

    return count;
};
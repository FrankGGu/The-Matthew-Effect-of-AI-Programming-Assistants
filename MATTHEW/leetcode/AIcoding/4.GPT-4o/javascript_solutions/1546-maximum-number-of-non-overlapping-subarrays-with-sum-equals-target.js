var maxNonOverlapping = function(nums, target) {
    let sum = 0, count = 0;
    const seenSums = new Set([0]);

    for (const num of nums) {
        sum += num;
        if (seenSums.has(sum - target)) {
            count++;
            sum = 0;
            seenSums.clear();
            seenSums.add(0);
        }
        seenSums.add(sum);
    }

    return count;
};
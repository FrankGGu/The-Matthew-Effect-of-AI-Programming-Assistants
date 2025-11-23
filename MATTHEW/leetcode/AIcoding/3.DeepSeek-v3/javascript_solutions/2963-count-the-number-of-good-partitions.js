var numberOfGoodPartitions = function(nums) {
    const lastOccurrence = new Map();
    for (let i = 0; i < nums.length; i++) {
        lastOccurrence.set(nums[i], i);
    }

    let end = 0;
    let partitions = 0;
    for (let i = 0; i < nums.length; i++) {
        end = Math.max(end, lastOccurrence.get(nums[i]));
        if (i === end) {
            partitions++;
        }
    }

    let result = 1;
    for (let i = 1; i < partitions; i++) {
        result = (result * 2) % 1000000007;
    }
    return result;
};
var maximumDistinctElements = function(nums) {
    const numSet = new Set();
    let operations = 0;

    nums.sort((a, b) => a - b);

    for (let num of nums) {
        if (!numSet.has(num)) {
            numSet.add(num);
        } else {
            while (numSet.has(num)) {
                num++;
                operations++;
            }
            numSet.add(num);
        }
    }

    return numSet.size;
};
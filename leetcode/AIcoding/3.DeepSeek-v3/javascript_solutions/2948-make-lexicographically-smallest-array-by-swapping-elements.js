var lexicographicallySmallestArray = function(nums, limit) {
    const n = nums.length;
    const indices = Array.from({ length: n }, (_, i) => i);
    indices.sort((a, b) => nums[a] - nums[b]);

    const result = new Array(n);
    let i = 0;
    while (i < n) {
        let j = i;
        const group = [indices[i]];
        while (j + 1 < n && nums[indices[j + 1]] - nums[indices[j]] <= limit) {
            j++;
            group.push(indices[j]);
        }
        group.sort((a, b) => a - b);
        const sortedValues = group.map(index => nums[index]).sort((a, b) => a - b);
        for (let k = 0; k < group.length; k++) {
            result[group[k]] = sortedValues[k];
        }
        i = j + 1;
    }
    return result;
};
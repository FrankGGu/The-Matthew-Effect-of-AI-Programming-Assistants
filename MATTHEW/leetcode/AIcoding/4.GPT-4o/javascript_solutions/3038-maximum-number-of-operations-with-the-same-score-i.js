var maximumOperations = function(nums, target) {
    const freq = new Array(101).fill(0);
    nums.forEach(num => freq[num]++);

    let operations = 0;
    for (let i = 1; i < target; i++) {
        if (freq[i] && freq[target - i]) {
            operations += Math.min(freq[i], freq[target - i]);
        }
    }

    return operations + (freq[target / 2] ? Math.floor(freq[target / 2] / 2) : 0);
};
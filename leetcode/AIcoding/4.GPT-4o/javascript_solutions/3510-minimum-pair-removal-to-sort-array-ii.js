var minimumOperations = function(nums) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    const freq = Object.values(count).sort((a, b) => b - a);
    const n = nums.length;
    let operations = 0;

    for (let i = 0; i < freq.length; i++) {
        if (i < n / 2) {
            operations += freq[i];
        } else {
            break;
        }
    }

    return operations;
};
var minOperations = function(nums, k) {
    let operations = 0;
    for (let num of nums) {
        if (num < k) {
            operations += (k - num);
        } else if (num > k) {
            operations += (num - k);
        }
    }
    return operations;
};
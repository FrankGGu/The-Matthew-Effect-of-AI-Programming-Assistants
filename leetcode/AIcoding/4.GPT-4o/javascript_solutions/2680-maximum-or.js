var maximumOR = function(nums, k) {
    let maxOR = 0;
    for (let num of nums) {
        maxOR |= num;
    }
    return maxOR | k;
};
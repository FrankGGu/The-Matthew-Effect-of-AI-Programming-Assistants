var minimumOperations = function(nums) {
    let uniquePositives = new Set();
    for (let num of nums) {
        if (num > 0) {
            uniquePositives.add(num);
        }
    }
    return uniquePositives.size;
};
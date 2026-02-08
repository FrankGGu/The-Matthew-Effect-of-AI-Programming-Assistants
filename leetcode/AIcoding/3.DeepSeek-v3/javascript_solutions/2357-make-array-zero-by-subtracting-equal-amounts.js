var minimumOperations = function(nums) {
    let unique = new Set(nums);
    unique.delete(0);
    return unique.size;
};
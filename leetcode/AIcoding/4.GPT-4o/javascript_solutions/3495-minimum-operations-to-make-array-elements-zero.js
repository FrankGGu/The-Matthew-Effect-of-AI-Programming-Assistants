function minimumOperations(nums) {
    const uniqueNums = new Set(nums);
    uniqueNums.delete(0);
    return uniqueNums.size;
}
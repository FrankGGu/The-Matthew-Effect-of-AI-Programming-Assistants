function minimumOperations(nums) {
    const uniqueNonZero = new Set(nums.filter(num => num > 0));
    return uniqueNonZero.size;
}
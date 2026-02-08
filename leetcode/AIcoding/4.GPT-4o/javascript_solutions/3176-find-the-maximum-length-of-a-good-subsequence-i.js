function maximumLengthOfGoodSubsequence(nums) {
    const uniqueNums = new Set(nums);
    return uniqueNums.size;
}
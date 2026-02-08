function kItemsWithMaximumSum(numOnes, numZeros, k) {
    return Math.min(numOnes, k) + Math.max(0, k - numOnes);
}
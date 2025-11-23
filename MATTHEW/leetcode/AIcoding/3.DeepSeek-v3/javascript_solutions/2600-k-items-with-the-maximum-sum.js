var kItemsWithMaximumSum = function(numOnes, numZeros, numNegOnes, k) {
    let sum = 0;
    if (k <= numOnes) {
        return k;
    } else if (k <= numOnes + numZeros) {
        return numOnes;
    } else {
        return numOnes - (k - numOnes - numZeros);
    }
};
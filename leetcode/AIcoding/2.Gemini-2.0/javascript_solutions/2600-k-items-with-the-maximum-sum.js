var kItemsWithMaximumSum = function(numOnes, numZeros, numNegOnes, k) {
    let sum = 0;
    if (k <= numOnes) {
        sum = k;
    } else if (k <= numOnes + numZeros) {
        sum = numOnes;
    } else {
        sum = numOnes - (k - numOnes - numZeros);
    }
    return sum;
};
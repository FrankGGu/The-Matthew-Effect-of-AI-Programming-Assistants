var kItemsWithMaximumSum = function(numOnes, numZeros, numNegOnes, k) {
    let sum = 0;

    let takeOnes = Math.min(k, numOnes);
    sum += takeOnes;
    k -= takeOnes;

    if (k === 0) {
        return sum;
    }

    let takeZeros = Math.min(k, numZeros);
    // sum += takeZeros * 0; // Does not change sum
    k -= takeZeros;

    if (k === 0) {
        return sum;
    }

    let takeNegOnes = Math.min(k, numNegOnes);
    sum += takeNegOnes * (-1);
    // k -= takeNegOnes; // No need to update k further as we are done

    return sum;
};
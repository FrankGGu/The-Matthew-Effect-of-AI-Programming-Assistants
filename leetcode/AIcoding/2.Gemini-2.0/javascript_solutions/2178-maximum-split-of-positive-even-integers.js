var maximumEvenSplit = function(finalSum) {
    if (finalSum % 2 !== 0) {
        return [];
    }

    const result = [];
    let currentSum = 0;
    let num = 2;

    while (currentSum + num <= finalSum) {
        result.push(num);
        currentSum += num;
        num += 2;
    }

    if (currentSum < finalSum) {
        result[result.length - 1] += (finalSum - currentSum);
    }

    return result;
};
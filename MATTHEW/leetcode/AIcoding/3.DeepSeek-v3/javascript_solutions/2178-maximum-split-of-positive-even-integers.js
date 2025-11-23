var maximumEvenSplit = function(finalSum) {
    if (finalSum % 2 !== 0) {
        return [];
    }
    let res = [];
    let current = 2;
    while (finalSum >= current) {
        res.push(current);
        finalSum -= current;
        current += 2;
    }
    if (finalSum > 0) {
        res[res.length - 1] += finalSum;
    }
    return res;
};
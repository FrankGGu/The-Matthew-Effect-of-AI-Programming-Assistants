function maximumEvenSplit(finalSum) {
    if (finalSum % 2 !== 0) return [];
    const result = [];
    for (let i = 2; finalSum > 0; i += 2) {
        if (finalSum >= i) {
            result.push(i);
            finalSum -= i;
        } else {
            result[result.length - 1] += finalSum;
            break;
        }
    }
    return result;
}
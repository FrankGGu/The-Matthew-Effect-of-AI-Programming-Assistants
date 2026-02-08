var largestValsFromLabels = function(values, labels, numWanted, useLimit) {
    const indexedValues = values.map((val, i) => [val, labels[i]]);
    indexedValues.sort((a, b) => b[0] - a[0]);

    let total = 0;
    const labelCount = {};

    for (const [val, label] of indexedValues) {
        if (numWanted <= 0) break;
        if (!labelCount[label]) labelCount[label] = 0;

        if (labelCount[label] < useLimit) {
            total += val;
            labelCount[label]++;
            numWanted--;
        }
    }

    return total;
};
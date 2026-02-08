var largestValsFromLabels = function(values, labels, numWanted, useLimit) {
    const items = values.map((value, index) => ({ value, label: labels[index] }));
    items.sort((a, b) => b.value - a.value);

    const labelCount = {};
    let total = 0;
    let sum = 0;

    for (const item of items) {
        if (total >= numWanted) break;

        const currentLabel = item.label;
        if (labelCount[currentLabel] === undefined) {
            labelCount[currentLabel] = 0;
        }

        if (labelCount[currentLabel] < useLimit) {
            sum += item.value;
            labelCount[currentLabel]++;
            total++;
        }
    }

    return sum;
};
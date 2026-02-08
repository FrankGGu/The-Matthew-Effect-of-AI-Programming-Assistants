function largestValuesFromLabels(values, labels, numWanted, useLimit) {
    const items = values.map((val, i) => ({ value: val, label: labels[i] }));
    items.sort((a, b) => b.value - a.value);

    const labelCount = {};
    let result = 0;
    let count = 0;

    for (const item of items) {
        if (count >= numWanted) break;
        if (labelCount[item.label] === useLimit) continue;

        result += item.value;
        labelCount[item.label] = (labelCount[item.label] || 0) + 1;
        count++;
    }

    return result;
}
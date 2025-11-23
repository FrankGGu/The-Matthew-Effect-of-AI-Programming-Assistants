var largestValsFromLabels = function(values, labels, numWanted, useLimit) {
    const items = [];
    for (let i = 0; i < values.length; i++) {
        items.push({ value: values[i], label: labels[i] });
    }

    items.sort((a, b) => b.value - a.value);

    let totalSum = 0;
    let itemsSelected = 0;
    const labelCounts = new Map();

    for (const item of items) {
        if (itemsSelected === numWanted) {
            break;
        }

        const currentLabelCount = labelCounts.get(item.label) || 0;

        if (currentLabelCount < useLimit) {
            totalSum += item.value;
            labelCounts.set(item.label, currentLabelCount + 1);
            itemsSelected++;
        }
    }

    return totalSum;
};
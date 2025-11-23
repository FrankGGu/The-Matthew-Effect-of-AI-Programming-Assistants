var largestValsFromLabels = function(values, labels, k, useLimit) {
    const n = values.length;
    const items = [];
    for (let i = 0; i < n; i++) {
        items.push({ value: values[i], label: labels[i] });
    }
    items.sort((a, b) => b.value - a.value);

    let totalValue = 0;
    const labelCounts = {};
    let itemsUsed = 0;

    for (const item of items) {
        const label = item.label;
        if (!labelCounts[label]) {
            labelCounts[label] = 0;
        }

        if (labelCounts[label] < useLimit) {
            totalValue += item.value;
            labelCounts[label]++;
            itemsUsed++;

            if (itemsUsed === k) {
                break;
            }
        }
    }

    return totalValue;
};
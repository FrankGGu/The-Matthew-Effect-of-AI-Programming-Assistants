function mostFrequentID(transactions) {
    const frequency = {};
    let maxCount = 0;
    let result = [];

    for (const id of transactions) {
        frequency[id] = (frequency[id] || 0) + 1;
        if (frequency[id] > maxCount) {
            maxCount = frequency[id];
        }
    }

    for (const id in frequency) {
        if (frequency[id] === maxCount) {
            result.push(id);
        }
    }

    return result.sort();
}
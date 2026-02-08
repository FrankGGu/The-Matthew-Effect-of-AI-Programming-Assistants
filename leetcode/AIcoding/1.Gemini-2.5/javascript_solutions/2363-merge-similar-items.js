var mergeSimilarItems = function(items1, items2) {
    const weights = {};

    for (const [value, weight] of items1) {
        weights[value] = (weights[value] || 0) + weight;
    }

    for (const [value, weight] of items2) {
        weights[value] = (weights[value] || 0) + weight;
    }

    const result = [];
    for (const value in weights) {
        result.push([parseInt(value), weights[value]]);
    }

    result.sort((a, b) => a[0] - b[0]);

    return result;
};
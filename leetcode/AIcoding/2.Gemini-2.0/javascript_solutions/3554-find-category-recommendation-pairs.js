var findHighAccessCategories = function(transactions) {
    const categoryCounts = {};
    for (const transaction of transactions) {
        const [category1, category2] = transaction;
        const sortedCategories = [category1, category2].sort();
        const key = sortedCategories.join(',');

        if (!categoryCounts[key]) {
            categoryCounts[key] = 0;
        }
        categoryCounts[key]++;
    }

    const result = [];
    for (const key in categoryCounts) {
        if (categoryCounts[key] >= 3) {
            const [category1, category2] = key.split(',').map(Number);
            result.push([category1, category2]);
        }
    }

    return result;
};
var findCategoryRecommendationPairs = function(recommendations) {
    const uniquePairs = new Set();

    for (const rec of recommendations) {
        const distinctCategories = Array.from(new Set(rec)).sort();

        for (let i = 0; i < distinctCategories.length; i++) {
            for (let j = i + 1; j < distinctCategories.length; j++) {
                const cat1 = distinctCategories[i];
                const cat2 = distinctCategories[j];

                const pairKey = `${cat1},${cat2}`;
                uniquePairs.add(pairKey);
            }
        }
    }

    const result = [];
    for (const pairKey of uniquePairs) {
        result.push(pairKey.split(','));
    }

    result.sort((a, b) => {
        if (a[0] === b[0]) {
            return a[1].localeCompare(b[1]);
        }
        return a[0].localeCompare(b[0]);
    });

    return result;
};
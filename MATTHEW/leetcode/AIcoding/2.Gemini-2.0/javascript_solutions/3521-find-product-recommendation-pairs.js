var findProductRecommendationPairs = function(products) {
    const n = products.length;
    const result = [];

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let common = 0;
            const set1 = new Set(products[i]);
            const set2 = new Set(products[j]);

            for (const product of set1) {
                if (set2.has(product)) {
                    common++;
                }
            }

            if (common >= 2) {
                result.push([i, j]);
            }
        }
    }

    return result;
};
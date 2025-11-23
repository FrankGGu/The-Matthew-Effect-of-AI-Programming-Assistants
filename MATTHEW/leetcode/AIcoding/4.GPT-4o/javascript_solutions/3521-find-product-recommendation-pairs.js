var findPairs = function(products, ratings) {
    const productMap = new Map();
    const result = [];

    for (let i = 0; i < products.length; i++) {
        if (!productMap.has(ratings[i])) {
            productMap.set(ratings[i], []);
        }
        productMap.get(ratings[i]).push(products[i]);
    }

    const uniqueRatings = Array.from(productMap.keys()).sort((a, b) => a - b);

    for (let i = 0; i < uniqueRatings.length; i++) {
        for (let j = i + 1; j < uniqueRatings.length; j++) {
            const rating1 = uniqueRatings[i];
            const rating2 = uniqueRatings[j];
            const products1 = productMap.get(rating1);
            const products2 = productMap.get(rating2);

            for (let p1 of products1) {
                for (let p2 of products2) {
                    result.push([p1, p2]);
                }
            }
        }
    }

    return result;
};
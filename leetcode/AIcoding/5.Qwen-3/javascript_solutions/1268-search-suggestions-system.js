function suggestedProducts(products, searchWord) {
    products.sort();
    const result = [];
    for (let i = 0; i < searchWord.length; i++) {
        const prefix = searchWord.substring(0, i + 1);
        const suggestions = [];
        for (let j = 0; j < products.length; j++) {
            if (products[j].startsWith(prefix)) {
                suggestions.push(products[j]);
                if (suggestions.length === 3) break;
            }
        }
        result.push(suggestions);
    }
    return result;
}
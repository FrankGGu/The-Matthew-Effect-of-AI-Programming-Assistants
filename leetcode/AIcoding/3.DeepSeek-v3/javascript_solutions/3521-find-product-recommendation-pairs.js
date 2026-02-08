var suggestedProducts = function(products, searchWord) {
    products.sort();
    let result = [];
    let input = '';
    for (let i = 0; i < searchWord.length; i++) {
        input += searchWord[i];
        let matches = [];
        for (const product of products) {
            if (product.startsWith(input)) {
                matches.push(product);
                if (matches.length === 3) break;
            }
        }
        result.push(matches);
    }
    return result;
};
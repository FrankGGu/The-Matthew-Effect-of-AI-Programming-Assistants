var suggestedProducts = function(products, searchWord) {
    products.sort();
    let result = [];
    let input = '';
    for (let char of searchWord) {
        input += char;
        let matches = [];
        for (let product of products) {
            if (product.startsWith(input)) {
                matches.push(product);
                if (matches.length === 3) break;
            }
        }
        result.push(matches);
    }
    return result;
};
var suggestedProducts = function(products, searchWord) {
    products.sort();
    let result = [];
    let prefix = '';

    for (let char of searchWord) {
        prefix += char;
        result.push(products.filter(product => product.startsWith(prefix)).slice(0, 3));
    }

    return result;
};
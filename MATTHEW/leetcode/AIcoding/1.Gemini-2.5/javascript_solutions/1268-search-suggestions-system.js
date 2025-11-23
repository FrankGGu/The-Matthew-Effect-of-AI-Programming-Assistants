var suggestedProducts = function(products, searchWord) {
    products.sort();

    const result = [];
    let currentSuggestions = products;

    for (let i = 0; i < searchWord.length; i++) {
        const char = searchWord[i];

        currentSuggestions = currentSuggestions.filter(product => 
            product.length > i && product[i] === char
        );

        result.push(currentSuggestions.slice(0, 3));
    }

    return result;
};
var fillMissingData = function(products, key, value) {
    return products.map(product => {
        if (product[key] === undefined) {
            return { ...product, [key]: value };
        }
        return product;
    });
};
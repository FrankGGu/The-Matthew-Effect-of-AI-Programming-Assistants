function findProductsWithValidSerialNumbers(products) {
    const validProducts = [];
    for (const product of products) {
        if (/^[A-Z]{3}-\d{3}-[A-Z]$/.test(product)) {
            validProducts.push(product);
        }
    }
    return validProducts;
}
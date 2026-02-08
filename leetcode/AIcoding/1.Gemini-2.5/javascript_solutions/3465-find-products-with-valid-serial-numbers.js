var findProductsWithValidSerialNumbers = function(products) {
    return products.filter(product => {
        const serialNumber = product.serialNumber;
        // Assuming a valid serial number:
        // 1. Must be a string.
        // 2. Must start with 'SN'.
        // 3. Must have a total length of 10 characters.
        return typeof serialNumber === 'string' &&
               serialNumber.startsWith('SN') &&
               serialNumber.length === 10;
    });
};
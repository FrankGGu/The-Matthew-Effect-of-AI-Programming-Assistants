function findProducts(products, valid_serial) {
    const validSerialNumbers = new Set(valid_serial.map(row => row.serial_number));
    const result = [];

    for (const product of products) {
        if (validSerialNumbers.has(product.serial_number)) {
            result.push({ product_id: product.product_id });
        }
    }

    return result;
}
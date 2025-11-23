function findProducts(products) {
    const result = [];
    for (const product of products) {
        const parts = product.split('-');
        if (parts.length !== 3) continue;
        const [prefix, serial, suffix] = parts;
        if (prefix.length !== 2 || suffix.length !== 2) continue;
        if (serial.length !== 5 || isNaN(serial)) continue;
        result.push(product);
    }
    return result;
}